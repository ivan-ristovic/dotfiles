#!/usr/bin/env python

from taskw import TaskWarrior
import os.path
import sys

home = os.getenv("HOME")
if home is None:
    print("failed to read HOME env var")
    sys.exit(1)

conky_file = home + '/.config/conky/task.conf'

filter = sys.argv[1] if len(sys.argv) > 1 else "pending"

tw = TaskWarrior()
tasks = tw.load_tasks(filter)

colors = {
    'H': 'color2',
    'M': 'color1',
    'L': 'color1',
    'S': 'color3',
}


def task_to_key(task):
    prio_trans = {
        'L': '3',
        'M': '2',
        'H': '1',
    }
    prio = prio_trans.get(task.get('priority')) if prio_trans.get(task.get('priority')) else '4'
    date = prio_trans.get(task.get('due')) if prio_trans.get(task.get('due')) else '9999999999'
    return "%s-%s-%4d-%s" % (date, prio, task['id'], task['uuid'])


def parse_tasks(tasks):
    projects = {}

    for task in tasks:
        key = task_to_key(task)

        due = task.get('due')
        if due:
            import datetime
            task['formatted_date'] = datetime.datetime.fromtimestamp(int(due)).strftime('%d/%m')
        else:
            task['formatted_date'] = None

        project = task['project'] if task.get('project') else 'other'
        if not projects.get(project):
            projects[project] = {}
        projects[project][key] = task

    return projects
     

def format_tasks(projects):
    formatted = ''
    for (project, tasks) in sorted(projects.items()):
        formatted += format_project(project, tasks)
    return formatted


def format_project(project, tasks, sort=True, indent=' ', maxw=40):
    formatted = ''

    if not tasks:
        return formatted

    # header
    formatted += "${color0}[%s] $color\n${voffset -8}${#212121}${hr}$color\n" % project

    tasks = sorted(tasks.items()) if sort else tasks
    for (_, task) in tasks:
        formatted += indent
        formatted += format_task(task, maxw)

    formatted += "${voffset 16}"
    return formatted


def format_task(task, maxw=40):
    if 'start' in task:
        color = colors['S']
    else:
        color = colors[task.get('priority') if task.get('priority') else 'L']
    date = task['formatted_date'] if task['formatted_date'] else '${#303030}inf${%s}' % color
    task_string = "${%(color)s}[%(id)s] %(desc)s $alignr %(date)s $color\n"
    return task_string % {
        'color': color,
        'id': task['id'],
        'date': date,
        'desc': task['description'].replace('#', '\\#')[:maxw]
    }


def is_high_priority(t):
    p = t.get('priority')
    return p is not None and p == 'H'


def write_conky_conf(path, payload, total, urgent):
    content = f"""conky.config = {{
    alignment = 'top_right',
    background = true,
    cpu_avg_samples = 2,
    default_shade_color = '000000',
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = false,
    draw_outline = false,
    draw_shades = false,
    gap_x = 350,
    gap_y = 40,
    maximum_width = 400,
    no_buffers = true,
    override_utf8_locale = true,
    own_window = true,
    own_window_argb_visual = false,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    own_window_transparent = true,
    own_window_type = 'override',
    total_run_times = 0,
    update_interval = 1.0,
    use_xft = true,
    xftalpha = 0.1,
    font = 'Bitstream Vera Sans:regular:size=9',
    default_outline_color = '5D7B86',
    default_color = '5D7B86',
    color0 = '#5d7b86',
    color1 = '#a0a0a0',
    color2 = '#ba4141',
    color3 = '#ffc067',
}}

conky.text = [[
${{voffset 8}}$color0${{goto 100}}${{font Bitstream Vera Sans:size=18}}Tasks$font\
${{voffset -8}}$alignr$color1${{font Bitstream Vera Sans:size=38}}{total}$font
$color1${{voffset -25}}${{goto 50}}${{font Bitstream Vera Sans:size=13}}priority$font\
${{voffset -3}}{'$color2' if urgent > 0 else '$color1'}${{goto 120}}${{font Bitstream Vera Sans:size=20}}{urgent} $font$color1$hr

{payload}
]]
"""

    with open(path, 'w', encoding='utf-8') as f:
        f.write('%s\n' % content)

    return content


parsed = parse_tasks(tasks[filter])
formatted = format_tasks(parsed)
print(formatted)
total_tasks = sum(map(lambda it: len(it[1]), parsed.items()))
urgent_tasks = sum(map(lambda it: sum([1 if is_high_priority(pt[1]) else 0 for pt in it[1].items()]), parsed.items()))
write_conky_conf(conky_file, formatted, total_tasks, urgent_tasks)
