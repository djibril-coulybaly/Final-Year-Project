> **Remove this block and start filling this template out. The following information may be given to you**
>
> Please leave the title of the „How to use“ section intact. Also don’t touch the formatting of the code block there but you can add as many code blocks as you want if you stick to the same formatting. But feel free to put any amount of any bash command in any line there. But please put in the commands as you would type them in a console, so no prefix _$_ or _§_.
>
> Background to this limitation: There is a script ‘pipeline’ which goes through a defined list of builders to execute. In order to find out how to execute a builder it parses its README.md file, searches for a line containing `## How to use` and then in that section it searches for code blocks with `bash` as their formatting style. So in order to make that script work you need to stick to the limitation. If you don’t want a command to be executed by the pipeline then create a separate code block like. Please note that this one has `sh` as formatting language
>
> ```sh
> ```
>
> and thus will be ignored by the `pipeline` script. Look in the source code of this file to see the formatting.

# <Name> Data Builder

| &nbsp;                                 | &nbsp;                                                       |
| -------------------------------------- | ------------------------------------------------------------ |
| The following extensions depend on it  | [extension name](https://github.com/trufi-association/trufi-server/tree/main/extensions) |
| This depends on the following builders |                                                              |

## Description



## How to use

To execute this builder you need to execute the following commands:

```bash

```

Additionally you can execute the following commands to achieve a certain result. The following commands won’t get executed by the `pipeline` script:

```sh
```

- The `.<file extension>` file out is located at `../data/<Country-City>/<finish path>`
