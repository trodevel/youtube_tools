#! /usr/bin/env python

'''
Simple tool for set intersection

Copyright (C) 2014 Sergey Kolevatov

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

'''


from __future__ import print_function
import sys
from sets import Set

def print_set( inp_set ):
    for item in inp_set :
        print( item )

name_1 = sys.argv[1]
name_2 = sys.argv[2]

sets_1 = Set( line.strip() for line in open( name_1 ) )
sets_2 = Set( line.strip() for line in open( name_2 ) )

inters = sets_1 & sets_2

if len( inters ):
    #print " %s" % inters
    print_set( inters )
else:
    print( "intersection is empty", file=sys.stderr )

