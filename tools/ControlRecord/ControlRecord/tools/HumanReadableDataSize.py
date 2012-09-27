def GetHumanReadableDataSize(size, precision=2):
    suffixes=['B','KB','MB','GB','TB','PB','EB','ZB','YB']
    suffixIndex = 0
    while size > 1024 and suffixIndex < len(suffixes)-1 :
        suffixIndex += 1 #increment the index of the suffix
        size = size/1024.0 #apply the division
    return "%.*f %s"%(precision,size,suffixes[suffixIndex])