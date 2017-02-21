# disk space usage
du -h

# set the max depth to look n-folders deep
du -h --max-depth=1
du -h -d=1

# human readable, max-depth 1 and then sorted by human readable 
# also reversed so largest at the top
du -h --max-depth=1 | sort -hr

# disk file system usage
df -h