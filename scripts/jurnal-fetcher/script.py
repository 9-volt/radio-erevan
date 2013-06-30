#!/usr/bin/env python

import urllib2
import datetime as dt

page = urllib2.urlopen('http://jurnal.md/ro/rss.xml')
string = page.read()

filename = dt.datetime.now().strftime('%Y-%m-%d.xml')
f = open(filename, 'w')
f.write(string)
f.close

