# Clean

Overview
---
A configurable clean command which cleans your project based on files and 
directories you specify.

Setup
---
`sh install.sh`

Usage
---
It works by creating a hidden file which contains all the folders and files you 
specified to be cleaned out; referencing it whenever you run the clean command. 
Depending on the flags you choose. The default directory for clean is the 
current one; however, you can be within subdirectories of your project 
and still clean it by simply specifying how many levels down from the 
root (where the .clean file resides) you are. The program will detect 
if you have a git directory and if so, create a _.gitignore_ if one 
doesn't exist, and add _.clean_ to it so that you don't upload the 
contents of your clean to github. This can simply be avoided as 
well, by deleting the _.clean_ from your gitignore as it 
doesn't add it every time you run the command. Also, 
everytime afterwards, all you need to do is run 
`clean` and it will work based on previously 
saved settings. Also by default, the clean 
command runs silently, but if you are 
interested in what it's doing and 
what is getting cleaned, simply 
specify the verbose flag.

###### flags
```
-d | --directory
-v | --verbose
-f | --file
```

###### example
```
clean . -d .ropeproject .cache .eggs -f \*.pyc \*.swp dump.txt
clean 4 -f \*.class -d .ropeproject bin
```

Note
---
Installation assumes you are within the _Clean_ project directory. You must always run 
the clean command from the project root unless specifying the levels of subdirectories 
you are under. Running `man clean` will also bring up useful information about the 
command.

**Testing has been done on BSD & Darwin environments; however, the command is 
intended to work across Linux platforms**

License
---
Licensed under the WTFPL - see [LICENSE](./LICENSE) for explicit details.

Version
---
1.0.0

Author 
---
[LinkedIn](https://www.linkedin.com/in/brandonjohnsonxyz/)
[Personal](https://brandonjohnson.life)
[GitHub](https://github.com/bitforce)
