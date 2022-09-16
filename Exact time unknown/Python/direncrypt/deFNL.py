import decrypt
import renamer
import sys
import os
def main():
    rootdir = os.path.dirname(sys.argv[0])
    if os.path.exists(os.path.join(rootdir,"key.data")):
        if os.path.exists(os.path.join(rootdir,"FilenameList")):
            de = decrypt.Codingfile()
            de.file_full_decoding_new_file(os.path.join(rootdir,"FilenameList"))
        else:
            print("Cannot Find file \"FilenameList\"")
    else:
        if os.path.exists(os.path.join(rootdir,"FilenameList")):
            print("Cannot Find file \"key.data\"")



if __name__=='__main__':
    main()
