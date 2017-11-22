# Pruner

Overview
---
A configurable prune command which cleans your project based on files and 
directories you specify.

Setup
---
`./install` _or_ `brew install pruner`

Usage
---
It works by creating a hidden file which contains all the folders and files you 
specified to be cleaned out; referencing it whenever you run the pruner command. 
Depending on the flags you choose. The default directory for pruner is the 
current one; however, you can be within subdirectories of your project 
and still clean it by simply specifying how many levels down from the 
root (where the .prune file resides) you are. The program will detect 
if you have a git directory and if so, create a _.gitignore_ if one 
doesn't eist, and add _.prune_ to it so that you don't upload the 
contents of your pruner to github. This can simply be avoided as 
well, by deleting the _.prune_ from your gitignore as it 
doesn't add it every time you run the command. Also, 
everytime afterwards, all you need to do is run 
`pruner` and it will work based on previously 
saved settings. Also by default, the pruner
command runs silently, but if you are 
interested in what it's doing and 
what is getting cleaned, simply 
specify the verbose flag.

###### flags
```
-d | --directory
-v | --verbose
-r | --remove
-w | --wipe
-f | --file
-i | --info
-h | --help
```

###### example
```
$ pruner . -d '.ropeproject .cache .eggs' -f '\*.pyc \*.swp dump.tt'
$ pruner 4 -f \*.class -d .ropeproject
```

Note
---
Installation assumes you are within the _Pruner_ project directory. You must always run 
the pruner command from the project root unless specifying the levels of subdirectories 
you are under. Running `man pruner` will also bring up useful information about the 
command.

The long options do not work; rather they are stated simply for clarification.

**Testing has only been done on BSD & Darwin environments; however, the command is 
intended to work across Linu platforms**

Update : 11-21-17
---
Turns out everything this does can essentially be done in one line using the `find` 
command and the `-prune` option (_go figure_); however, if you do find this more 
useful, then I'm glad your appreciation does this project some justice.

License
---
Licensed under the WTFPL - see [LICENSE](./LICENSE) for eplicit details.

Version
---
1.0.0

Author 
---
[LinkedIn](https://www.linkedin.com/in/brandonjohnsonyz/)
[Personal](https://brandonjohnson.life)
[GitHub](https://github.com/bitforce)
