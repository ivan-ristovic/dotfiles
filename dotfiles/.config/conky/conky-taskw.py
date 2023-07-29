#!/usr/bin/env python
# -*- coding: utf-8 -*-

from taskw import TaskWarrior
import os.path, time

class TConky (object):

    NONE = "--- \n"

    CONKY_HEADER = """
conky.config = {
    alignment = 'top_right',
    background = false,
    cpu_avg_samples = 2,
    --default_color = '656667',
    --default_outline_color = '828282',
    default_shade_color = '000000',
    double_buffer = true,
    draw_borders = false,
    draw_graph_borders = false,
    draw_outline = false,
    draw_shades = false,
    gap_x = 300,
    maximum_width = 500,
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
    --font = 'Hack Nerd Font:regular:size=10',
    font = 'Bitstream Vera Sans:regular:size=9',
    default_outline_color = '5D7B86',
    default_color = '5D7B86',
    color0 = '5d7b86',
    color1 = 'a0a0a0',
    color2 = 'ba4141',
}

conky.text = [[
--${execi 5 ~/.config/conky/conky-taskw.py}
"""

    COLORS = {
            'H' : {
                'even': 'color2',
                'odd' : 'color2',
            },
            'M' : {
                'even': 'color1',
                'odd' : 'color1',
            },
            'L' : {
                'even': 'color1',
                'odd' : 'color1',
            },
        }


    def __init__(self):
        warrior     = TaskWarrior()
        tasks       = warrior.load_tasks()
        self.tasks  = TConky.preprocess_tasks(tasks)
        self.display_string = self.get_display_string()


    @staticmethod
    def preprocess_tasks(tasks):
        return {
            'pending'  : TConky.preprocess_task_list(tasks['pending']),
            'completed': TConky.preprocess_task_list(tasks['completed'])
        }


    @staticmethod
    def preprocess_task_list(tasks):
        """
        completed : [tag] / [project]
        pending :
        """
        projects = {}
        tags     = {}

        id = 0
        for task in tasks:

            # ID
            id += 1
            task['id'] = '%0*d' % (2, id)
            # DATE FORMAT:
            due = task.get('due')
            if due:
                import datetime
                task['formated_date'] = (datetime.datetime.fromtimestamp(int(due)).strftime('%d/%m'))
            else:
                task['formated_date'] = None

            #PROJECTS:
            projects['other'] = {}
            if task.get('project'):
                if not projects.get(task.get('project')):
                    projects[task['project']] = {}
                projects[task['project']][TConky.task_to_key(task)] = task
            else:
                projects['other'][TConky.task_to_key(task)] = task

            #TAGS:
            task['tags_list'] = []
            if task.get('tags'):
                for tag in task['tags']:
                    task['tags_list'].append(tag)
                    if not tags.get(tag):
                        tags[tag] = {}
                    tags[tag][TConky.task_to_key(task)] = task

        return {
            'projects': projects,
            'tags'    : tags
        }


    @staticmethod
    def task_to_key(task):
        prio_trans = {
            'L' : '3',
            'M' : '2',
            'H' : '1'
        }
        prio = prio_trans.get(task.get('priority')) if prio_trans.get(task.get('priority')) else '4'
        date = prio_trans.get(task.get('due')) if prio_trans.get(task.get('due')) else '9999999999'
        desc = (task['description'].replace(' ',''))[:25]
        return "%s%s%s%s" % (date, prio, desc, task['entry'])


    @staticmethod
    def write_string_to_file(string, file):
        f = open(file, 'w', encoding='utf-8')
        f.write('%s\n' % string)
        f.close()

    @staticmethod
    def key_in_list(needles, heystack):
        return any([n in heystack for n in needles])

    @staticmethod
    def display_task_list(task_list, skip_tag=(), skip_id=False, skip_date=False):
        return_string = ''
        tkeys = sorted(    task_list.keys())
        even = False
        for task_key in tkeys:
            task = task_list[task_key]
            if not TConky.key_in_list(task['tags_list'], skip_tag):
                even = not even
                return_string += TConky.display_task(task, even, skip_id, skip_date)
        return_string += "\n"
        return return_string


    def display_tag(self, tag, header=None, skip_tag=(), done=False, skip_id=False, skip_date=False):
        return self.display_stuff('tags', tag, header, skip_tag, done, skip_id, skip_date)


    def display_project(self, projects, header=None, skip_tag=(), done=False, skip_id=False, skip_date=False):
        return self.display_stuff('projects', projects, header, skip_tag, done, skip_id, skip_date)


    def display_stuff(self, type, stuff, header=None, skip_tag=(), done=False, skip_id=False, skip_date=False):
        tasks = self.tasks['pending' if not done else 'completed'][type].get(stuff)
        if not tasks:
            return ''

        tstring = ''
        if not len(tasks):
            return ''
        try:
            tstring += TConky.display_task_list(tasks, skip_tag, skip_id, skip_date)
        except KeyError:
            tstring += TConky.NONE

        if len(tstring.strip()) > 0:
            return TConky.print_headline(header if header else TConky.format_str(stuff)) + tstring
        return ''

    @staticmethod
    def format_str(string):
        return string[0].upper() + string[1:] if len(string) > 1 else string.upper()

    @staticmethod
    def update(conky_file, shadow_file):
        should_update = False
        import pathlib
        try:
            pathlib.Path.touch(conky_file, exist_ok=False)
            should_update = True
        except FileExistsError:
            pass
        try:
            pathlib.Path.touch(shadow_file, exist_ok=False)
            should_update = True
        except FileExistsError:
            pass

        if should_update:
            return True
        
        conky_file_time  = time.ctime(os.path.getmtime(conky_file))
        shadow_file_time = time.ctime(os.path.getmtime(shadow_file))
        return conky_file_time < shadow_file_time


    ##
    # CHANGE THIS
    ##
    @staticmethod
    def display_task(task, even=False, skip_id=False, skip_date=False):
        color = TConky.COLORS[task.get('priority') if task.get('priority') else 'L']['even' if even else 'odd']
        date  = '' if skip_date else task['formated_date'] if task['formated_date'] else '${#303030}inf${%s}' % color
        task_string = " ${%(color)s}[%(id)s] %(desc)s $alignr %(date)s $color\n" if not skip_id else " ${%(color)s}%(desc)s $alignr %(date)s $color\n"
        return task_string % {
                'color': color,
                'id'   : task['id'],
                'date' : date,
                'desc' : task['description'].replace('#','\\#')[:40]
            }

    @staticmethod
    def print_headline(headline):
        return "${color0}%s $color\n${voffset -8}${#212121}${hr}$color\n" % headline

    def get_display_string(self):
        tstring = TConky.CONKY_HEADER

        # TODAY:
        tstring += self.display_tag('today', '[Today]')

        # PROJECTS (ALL)
        skip = ('',)
        tkeys = sorted(self.tasks['pending']['projects'].keys())
        for tasks_key in tkeys:
            if tasks_key not in skip:
                tstring += self.display_project(tasks_key, '[' + tasks_key + ']', ('today'))

        # CHOSEN PROJECT
        # tstring += self.display_project('projects', "[PRO] Projects", ('today'))

        tstring += '\n]]'
        return tstring

if __name__ == '__main__':

    home = os.getenv("HOME")
    if home is None:
        print("failed to read HOME env var")
        import sys
        sys.exit(1)
    conky_file  = home + '/.config/conky/task.conf'
    shadow_file = home + '/.task.shadow'

    from optparse import OptionParser
    parser = OptionParser('usage: %prog -f FILE')
    parser.add_option("-f", "--file", dest="file")
    (opt, args) = parser.parse_args()

    if opt.file or TConky.update(conky_file, shadow_file):
        import os
        os.system('task > /dev/null')
        tc = TConky()
        TConky.write_string_to_file(tc.display_string, conky_file)
