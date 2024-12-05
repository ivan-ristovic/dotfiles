#!/usr/bin/env python

import os
import sys
import json
import time
import requests
import datetime
from matplotlib import pyplot as plt

debug = len(sys.argv) > 1 and sys.argv[1] == '-v'


def dbg(msg):
    if debug:
        print(msg)


def get_settings():
    lat = os.getenv('LAT', 44.8178131)
    lon = os.getenv('LON', 20.4568974)
    cache_path = os.getenv('OPENWEATHER_HOURLY_CACHE_PATH', '/tmp/hourly-weather-cached.json')
    chart_path = os.getenv('OPENWEATHER_HOURLY_CHART_PATH', '/tmp/hourly-weather.png')
    api_key = os.getenv('OPENWEATHER_API_KEY')
    if not api_key:
        try:
            with open(f'{os.environ['HOME']}/.apikeys/openweather.key', 'r') as f:
                api_key = f.readline().strip()
        except IOError as e:
            print('failed to read apikey')
            print(e)
            sys.exit(1)
    return (lat, lon, api_key, cache_path, chart_path)


def perform_request(api_key, lat, lon):
    url = f'https://api.openweathermap.org/data/3.0/onecall?units=metric&lat={lat}&lon={lon}&exclude=current,minutely,daily&appid={api_key}'
    dbg(url)

    headers = {
        'User-Agent': 'curl/8',
    }
    response = requests.get(url, headers=headers)
    if response.status_code != 200:
        print('error:', response.status_code)
        print(response.json())
        sys.exit(2)

    return response.json()


def get_cached_response(path, alive_time=1800):
    r = None
    if os.path.exists(path):
        mtime = int(os.path.getmtime(path))
        now = int(time.time())
        if abs(now - mtime) < alive_time:
            try:
                with open(path, 'r') as f:
                    r = json.load(f)
            except:
                pass
    return r


def cache_response(r, path):
    try:
        with open(path, 'w') as f:
            json.dump(r, f)
    except:
        pass


def plot(w, output_path):

    # Color palette
    color_map = ['#ffffff', '#5dade2', '#16a085', '#d4ac0d', '#f39c12', '#f1948a']

    # Data
    xs = [datetime.datetime.fromtimestamp(h['dt']).strftime('%d.\n%Hh') for h in w['hourly'][:32]]
    ts = [h['temp'] for h in w['hourly'][:32]]
    ps = [h['pop'] for h in w['hourly'][:32]]
    rs = [h['rain']['1h'] if 'rain' in h else 0 for h in w['hourly'][:32]]
    ss = [h['snow']['1h'] if 'snow' in h else 0 for h in w['hourly'][:32]]
    cs = [color_map[int(max(0, min(t // 10 + 1, len(color_map))))] for t in ts]
    assert len(xs) == len(ts)

    # Config
    plt.style.use('dark_background')
    f = plt.figure()
    f.set_figwidth(10)
    f.set_figheight(5)
    f.set_dpi(80)
    
    # Scatter temperatures
    plt.scatter(xs, ts, 20, c=cs)

    # Label pop (prob of precipitation)
    has_pop = False
    for i, p in enumerate(ps):
        if p > 0:
            has_pop = True
            """ plt.gca().annotate(f'{int(p*100)}%', (i, rs[i]), color='#ffffff') """
            plt.text(i, max(rs[i], ss[i]) + 0.25, f'{int(p*100)}%', color='#ffffff', ha='center', fontsize='xx-small')

    # Plot rain and snow
    if has_pop:
        plt.bar(xs, rs, color='#3399ff', alpha=0.5)
        plt.bar(xs, ss, color='#ffffff', alpha=0.5)
    
    # Show every 2nd label
    for label in plt.gca().xaxis.get_ticklabels()[::2]:
        label.set_visible(False)

    # Vertical lines for day separators
    ds = filter(lambda p: p[1].endswith('00h'), enumerate(xs))
    for i, d in ds:
        plt.axvline(x=i, color='w', label='day', alpha=0.2, c='gray')

    plt.savefig(output_path, transparent=True)


if __name__ == '__main__':
    lat, lon, api_key, cache_path, output_path = get_settings()
    response = get_cached_response(cache_path)
    if response is None:
        dbg('No cached response found')
        response = perform_request(api_key, lat, lon)
        cache_response(response, cache_path)
    else:
        dbg('Using cached response')
    plot(response, output_path)

