#!/usr/bin/python3
#-*- coding: utf-8 -*-
from os import path
import os
import glob
import stat
import sys
import shutil
from grp import getgrgid
from pwd import getpwuid
from optparse import OptionParser

BLUE    ="159"
GREEN   ="85"
YELLOW  ="229"
LTGREY  ="252"
DKGREY  ="244"
INDIGO  ="105"
ORANGE  ="216"
RED     ="160"

FILE    ="FILE"
DIR     ="DIR"
SRC     ="SRC"
COMPRESS="COMPRESS"
IMG     ="IMG"
AUDIO   ="AUDIO"
VIDEO   ="VIDEO"
TXT     ="TXT"
DOTFILE ="DOTFILE"
EXE     ="EXE"
COMPILED="COMPILED"
TMP     ="TMP"

# Filetype modifiers
LINK = u" \uf0c1 "

# Specific file name desctriptions.
# Format: "NAME": [u"ICON","COLOR CODE"]
FILENAMES = {
              "Makefile":   [u"", TXT],
              "README":     [u"\uf128", TXT],
              "readme":     [u"\uf128", TXT],
              "LICENSE":    [u"", TXT],
              "license":    [u"", TXT],
              ".gitignore": [u"", TXT],
              ".git":       [u"", TXT],
              "tags":       [u"\uf02c", TXT],
}

# File extension descriptions.
# Format: "EXTENSION": [u"ICON","COLOR CODE"]
EXTENSIONS = [
        {
              # Generic types
              ":FILE":	    [u"", FILE],
              ":DIRECTORY":	[u"", DIR],
              ":DOTFILE":   [u"", DOTFILE],
        },

        {
              # Executables
              "out":	    [u"", EXE],
              "":	        [u"", EXE],
              "exe":	    [u"", EXE],
              },

        {
              # Archives
              "7z":			[u"", COMPRESS],
              "bz":			[u"", COMPRESS],
              "bz2":		[u"", COMPRESS],
              "gz":			[u"", COMPRESS],
              "tar":		[u"", COMPRESS],
              "xz":			[u"", COMPRESS],
              "zip":		[u"", COMPRESS],
              },

        {
              # Images
              "ai":			[u"", IMG],
              "bmp":		[u"", IMG],
              "gif":		[u"", IMG],
              "ico":		[u"", IMG],
              "jpeg":		[u"", IMG],
              "jpg":		[u"", IMG],
              "png":		[u"", IMG],
              "psb":		[u"", IMG],
              "psd":		[u"", IMG],
              "ts":			[u"", IMG],
              },

        {
              # Audio
              "mp3":        [u"", AUDIO],
              "wav":        [u"", AUDIO],
              },

        {
              # Video
              "mkv":        [u"", VIDEO],
              },

        {
              # General file formats
                # Office
              "doc":        [u"\uf1c2", TXT],
              "docx":       [u"\uf1c2", TXT],
              "odt":        [u"\uf1c2", TXT],
              "xls":        [u"\uf1c3", TXT],
              "xlsx":       [u"\uf1c3", TXT],
              "ods":        [u"\uf1c3", TXT],
              "ppt":        [u"\uf1c4", TXT],
              "pptx":       [u"\uf1c4", TXT],
              "odp":        [u"\uf1c4", TXT],
                # Misc
              "pdf":        [u"\uf1c1", TXT],
              "ttf":        [u"\uf031", TXT],
              },

        {
              # Temporary Files
              "tmp":        [u"", TMP],
              "swp":        [u"", TMP],
              },

        {
              # Simple Text
              "csv":		[u"", TXT],
              "dump":		[u"", TXT],
              "log":		[u"", TXT],
              "markdown":	[u"", TXT],
              "md":			[u"", TXT],
              "rss":		[u"", TXT],
              "t":			[u"", TXT],
              "txt":		[u"", TXT],
              "conf":		[u"", TXT],
              },

        {
              # Compiled Files (but not executable)
              "class":		[u"", COMPILED], 
              "o":		    [u"", COMPILED], 
              },

        {
              # Source Code Files
              "asm":		[u"\uf2db", SRC],
              "s":		    [u"\uf2db", SRC],
              "S":		    [u"\uf2db", SRC],
              "bat":		[u"", SRC],
              "c":			[u"", SRC],
              "h":			[u"\uf1dc", SRC],
              "cc":			[u"", SRC],
              "c++":		[u"", SRC],
              "cpp":		[u"", SRC],
              "cxx":		[u"", SRC],
              "hh":			[u"\uf1dc", SRC],
              "hpp":		[u"\uf1dc", SRC],
              "clj":		[u"", SRC],
              "cljc":		[u"", SRC],
              "cljs":		[u"", SRC],
              "coffee":		[u"", SRC],
              "cp":			[u"", SRC],
              "css":		[u"", SRC],
              "d":			[u"", SRC],
              "dart":		[u"", SRC],
              "db":			[u"", SRC],
              "diff":		[u"", SRC],
              "edn":		[u"", SRC],
              "ejs":		[u"", SRC],
              "erl":		[u"", SRC],
              "f#":			[u"", SRC],
              "fs":			[u"", SRC],
              "fsi":		[u"", SRC],
              "fsscript":	[u"", SRC],
              "fsx":		[u"", SRC],
              "go":			[u"", SRC],
              "hbs":		[u"", SRC],
              "hrl":		[u"", SRC],
              "hs":			[u"", SRC],
              "htm":		[u"", SRC],
              "html":		[u"", SRC],
              "ini":		[u"", SRC],
              "java":		[u"", SRC],
              "jl":			[u"", SRC],
              "js":			[u"", SRC],
              "json":		[u"", SRC],
              "jsx":		[u"", SRC],
              "less":		[u"", SRC],
              "lhs":		[u"", SRC],
              "lua":		[u"", SRC],
              "ml":			[u"λ", SRC],
              "mli":		[u"λ", SRC],
              "mustache":	[u"", SRC],
              "php":		[u"", SRC],
              "pl":			[u"", SRC],
              "pm":			[u"", SRC],
              "py":			[u"", SRC],
              "pyc":		[u"", SRC],
              "pyd":		[u"", SRC],
              "pyo":		[u"", SRC],
              "rb":			[u"", SRC],
              "rlib":		[u"", SRC],
              "rs":			[u"", SRC],
              "scala":		[u"", SRC],
              "scm":        [u"λ", SRC],
              "scss":		[u"", SRC],
              "sh":			[u"", SRC],
              "csh":		[u"", SRC],
              "zsh":		[u"", SRC],
              "fish":		[u"", SRC],
              "bash":		[u"", SRC],
              "zsh":		[u"", SRC],
              "tex":        [u"\uf0db", SRC],
              "slim":		[u"", SRC],
              "sln":		[u"", SRC],
              "sql":		[u"", SRC],
              "styl":		[u"", SRC],
              "suo":		[u"", SRC],
              "twig":		[u"", SRC],
              "vim":		[u"", SRC],
              "xul":		[u"", SRC],
              "yml":		[u"", SRC],
              }
              ]

for ext in EXTENSIONS:
    for key, value in sorted(ext.items()):
        s = "{"
        s += "\"{}\"".format(key);
        s += ","
        for i in range(10 - len(key)):
            s += ' '
        s += "\"{}\"".format(value[0]);
        s += ","
        for i in range(7 - len(value[0])):
            s += ' '
        s += "{}".format(value[1]);
        for i in range(10 - len(value[1])):
            s += ' '
        s += "},"
        print(s)

for key, value in sorted(FILENAMES.items()):
    s = "{"
    s += "\"{}\"".format(key);
    s += ","
    for i in range(10 - len(key)):
        s += ' '
    s += "\"{}\"".format(value[0]);
    s += ","
    for i in range(7 - len(value[0])):
        s += ' '
    s += "{}".format(value[1]);
    for i in range(10 - len(value[1])):
        s += ' '
    s += "},"
    print(s)
