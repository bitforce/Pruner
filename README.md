# Clean

Overview
---
A configurable clean command which cleans your project based on files and directories you specify.

Setup
---
`brew install clean` _or_ `./install.sh`

Usage
---
It works by creating a [temporary] file which contains all the folders/files you specified to be 
cleaned out and references it whenever you run the clean command. Depending on the flags you 
choose, the clean command, you can modify the ouput and which directories are cleaned. The 
default directory for clean is the current one. The program will detect if you have a git 
directory and if so, create a _.gitignore_ if one doesn't exist, and add _.clean_ to it 
so that you don't upload the contents of your clean to github. This can simply be 
avoided as well, by deleting the _.clean_ from your gitignore as it doesn't add 
it every time you run the command. Also, everytime afterwards, all you need to 
do is run `clean` and it will work based on previously saved settings.

When the point in time comes that you need to configure the settings, you can either write over 
your previous settings using the `-w` flag or if you want to add more to you current list of 
files and directories to clean, just repeat what you did for basic usage and it will add.


###### flags

-d | --directory
-s | --silent
-w | --write
-f | --file


###### example

clean . -d .ropeproject .cache .eggs -f .pyc .swp
clean my/folder/ -f \*.txt -d res bin


Note
---
You must always run the clean command from the project root. Running `man clean` will also 
bring up useful information about the command.

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
