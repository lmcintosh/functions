#!/bin/bash
#
# edit_worklog.sh - script to edit (and create if necessary)
#                   a rotating weekly work log file
#
# Author: Barry Stump
 
# this is the path to the weekly log folder
LOG_DIR=$HOME/Dropbox/notes/worklog
 
# the files are named by the first day of the week (most recent Monday)
LOG_FILE=$(date -v-monday '+%Y-%m-%d.txt')
 
# does today's file not exist yet?
if [ ! -e $LOG_DIR/$LOG_FILE ]; then
 
    # create new log file with a line for each weekday...
    # (this version is for the BSD date command that
    # comes with OS X. For GNU date, use something like
    # -d'monday+2 days')
 
    # Monday
    date -v-mon '+%A, %m/%d' > $LOG_DIR/$LOG_FILE
    echo >> $LOG_DIR/$LOG_FILE
    # Tuesday
    date -v-mon -v+1d '+%A, %m/%d' >> $LOG_DIR/$LOG_FILE
    echo >> $LOG_DIR/$LOG_FILE
    # Wednesday
    date -v-mon -v+2d '+%A, %m/%d' >> $LOG_DIR/$LOG_FILE
    echo >> $LOG_DIR/$LOG_FILE
    # Thursday
    date -v-mon -v+3d '+%A, %m/%d' >> $LOG_DIR/$LOG_FILE
    echo >> $LOG_DIR/$LOG_FILE
    # Friday
    date -v-mon -v+4d '+%A, %m/%d' >> $LOG_DIR/$LOG_FILE
    echo >> $LOG_DIR/$LOG_FILE
 
fi
 
# open it up (with a small window)
vim $LOG_DIR/$LOG_FILE
