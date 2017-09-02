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

FILE    =ORANGE
DIR     =BLUE
SRC     =GREEN
COMPRESS=YELLOW
IMG     =LTGREY
AUDIO   =LTGREY
VIDEO   =LTGREY
TXT     =INDIGO
DOTFILE =INDIGO
EXE     =GREEN
COMPILED=GREEN
TMP     =DKGREY

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
EXTENSIONS = {
              # Generic types
              ":FILE":	    [u"", FILE],
              ":DIRECTORY":	[u"", DIR],
              ":DOTFILE":   [u"", DOTFILE],

              # Executables
              "out":	    [u"", EXE],
              "":	        [u"", EXE],
              "exe":	    [u"", EXE],

              # Archives
              "7z":			[u"", COMPRESS],
              "bz":			[u"", COMPRESS],
              "bz2":		[u"", COMPRESS],
              "gz":			[u"", COMPRESS],
              "tar":		[u"", COMPRESS],
              "xz":			[u"", COMPRESS],
              "zip":		[u"", COMPRESS],

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

              # Audio
              "mp3":        [u"", AUDIO],
              "wav":        [u"", AUDIO],

              # Video
              "mkv":        [u"", VIDEO],

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

              # Temporary Files
              "tmp":        [u"", TMP],
              "swp":        [u"", TMP],

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

              # Compiled Files (but not executable)
              "class":		[u"", COMPILED], 
              "o":		    [u"", COMPILED], 

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

# Formats colors. Makes printing a bit easier.
def colorfmt(c):
    return "\x1b[38;5;%sm" % c

# format the permissions bits as an rwx... string
def permissions_to_unix_name(st):
    if (stat.S_ISLNK(st.st_mode)):
        permStr = 'l'
    elif (stat.S_ISDIR(st.st_mode)):
        permStr = 'd'
    else:
        permStr = '-'
    perm = st.st_mode
    permSet = ['r', 'w', 'x']
    for i in range(2, -1, -1):
        for j in range (2, -1, -1):
            if (perm >> (3 * i + j)) & 0x1 == 1:
                permStr += permSet[-(j + 1)]
            else:
                permStr += '-'
    return permStr

# check if the file has the user x bit set
def is_exe(file_stat):
    try:
        return file_stat.st_mode >> 6 & 0x1
    except KeyError:
        return ""

# get the user's name from the uid
def get_user_name(file_stat):
    try:
        return getpwuid(file_stat.st_uid).pw_name
    except KeyError:
        return ""

#def the group's name from the gid
def get_group_name(file_stat):
    try:
        return getgrgid(file_stat.st_gid).gr_name
    except KeyError:
        return ""

# format the list of files to fit in compact columns for printing
def pad_columns(files):
    rows = 0
    totalSize = 0
    width = shutil.get_terminal_size().columns
    colList = None
    output = ""

    # find how many columns are required to list all of the files
    while(totalSize > width or rows == 0):
        rows += 1
        totalSize = 0
        colList = []
        
        # find all of the files can be listed in the provided number of rows
        for col in range((len(files) + rows - 1) // rows):
            colWidth = 0
            # find the widest row in the column
            for row in range(rows):
                # break if there isn't another file
                if col * rows + row + 1 > len(files):
                    break
                colWidth = max(colWidth, len(files[col * rows + row][0]) + 2)
            colList.append(colWidth)
            totalSize += colWidth

    # generate the output
    for row in range(rows):
        for col in range((len(files) + rows - 1) // rows):
            if col * rows + row + 1> len(files):
                break
            output += files[col * rows + row][0].ljust(colList[col])
        output += "\n"
    return output

# return a human readable file size
def get_file_size(file_stat):
    size = file_stat.st_size
    if size <= 1024:
        return "%4d B  " % size
    size /= 1024

    if size <= 1024:
        return "%4d KiB" % size
    size /= 1024

    if size <= 1024:
        return "%4d MiB" % size
    size /= 1024

    return "%4d GiB" % size

# get icon and color for a normal file
def formatFile(f, base):
    # add emphasis to executables
    # follow symlinks to find if target is executable
    if (is_exe(os.stat(f))):
        file_emphasis = "\x1b[1m"
    else:
        file_emphasis = "\x1b[0m"

    # find icon for filetype
    (name, ext) = path.splitext(base)

    # Lookup specific file name (ex. Makefile)
    if ext == "" and name in FILENAMES:
        file_line = ("%s %s" % (FILENAMES[name][0], base))
        file_color = colorfmt(FILENAMES[name][1])

    # Lookup by file extension (ex. hello.txt)
    else:
        file_line, file_color = formatFileByExt(base, ext)

    return file_line, file_color, file_emphasis

# get icon and color for a file, by the file's extension
def formatFileByExt(name, ext):
    ext = ext.replace(".", "")
    # Handle Dotfiles (ex .vimrc)
    if ext == "" and name[0] == '.':
        file_line = ("%s %s" % (EXTENSIONS[u":DOTFILE"][0], name))
        file_color = colorfmt(EXTENSIONS[u":DOTFILE"][1])

    # Handle known extensions (ex hello.txt)
    elif ext in EXTENSIONS:
        file_line = ("%s %s" % (EXTENSIONS[ext][0], name))
        file_color = colorfmt(EXTENSIONS[ext][1])

    # Default formatting for unknown filetypes
    elif ext not in EXTENSIONS:
        file_line = ("%s %s" % (EXTENSIONS[u":FILE"][0], name))
        file_color = colorfmt(EXTENSIONS[u":FILE"][1])

    return file_line, file_color

# get icon and color for a directory
def formatDir(name):
    file_line = ("%s %s" % (EXTENSIONS[u":DIRECTORY"][0], name))
    file_color = colorfmt(EXTENSIONS[u":DIRECTORY"][1])

    return file_line, file_color


# format the file in the list format with user, group, permissions etc
def getListFormat(f, file_line):
    try:
        # don't follow symlinks when getting permissions bits
        file_stat = os.lstat(f)
        file_line = u"{:<15}{:<10}{:<10}{:<10}{}".format(
                            permissions_to_unix_name(file_stat),
                            get_user_name(file_stat),
                            get_group_name(file_stat),
                            get_file_size(file_stat), file_line)
    except OSError:
        file_line = f
    return file_line

if __name__ == '__main__':
    parser = OptionParser(usage="usage: %prog [options] [directory]")
    parser.add_option(
        "-l",
        "--list",
        action="store_true",
        default=False,
     dest="is_list")
    parser.add_option(
        "-a", 
        "--all", 
        action="store_true",
        default=False,
        dest="is_all")
    #parser.add_option("-d", "--dir", dest="dir", default='')
    (options, args) = parser.parse_args()

    if (len(args) == 0):
        dir = ''
    else:
        dir = args[0]

    # get all of the files in the directory
    files =  glob.glob(dir + '*')
    if (options.is_all):
        files += glob.glob(dir + '.*')
    formattedfiles = []

    # format each file
    for f in sorted(files, key=lambda v: v.upper(),):
        file_emphasis = "\x1b[0m"
        base = path.basename(f)

        # format a normal file
        if path.isfile(f):
            file_line, file_color, file_emphasis = formatFile(f, base)
        #TODO probably should handle sockets etc...
        # format as a directory
        else:
            file_line, file_color = formatDir(base)

        # add link formatting
        if path.islink(f):
            file_line += LINK
            if  options.is_list:
                file_line += os.readlink(f)

        # add list formatting
        if options.is_list:
            file_line = getListFormat(f, file_line)
        formattedfiles.append((file_line, file_color, file_emphasis))
    fstr = ''
 
    # handle list printing and column print formatting
    output = ''
    if not options.is_list:
        output = pad_columns(formattedfiles)
    else:
        for f in formattedfiles:
            output += f[0]+"\n"

    # insert formatting characters
    for f in formattedfiles:
        output = output.replace(f[0], f[2]+f[1]+f[0])

    print(output.strip('\n'))
