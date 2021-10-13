# gevel

This is a clone of the [original](http://www.sigaev.ru/git/gitweb.cgi?p=gevel.git;a=summary) *gevel* implementation by *Teodor Sigaev*.
I've changed some of the files to make it compatible with PostgreSQL v13.4.

## How to install

If you have installed PostgreSQL by your package manager then it is likely that you don't have to edit the script, but maybe you should change the following paths:

- `POSTGRESQL_INCLUDE_DIRECTORY`: the directory of the precompiled PostgreSQL header and source files
- `POSTGRESQL_EXTENSION_DIRECTORY`: the directory where your extensions live (should contain subdirectories like *btree_gist, cube, etc.*)
- `POSTGRESQL_LIBRARY_DIRECTORY`: the directory where the shared libraries and objects (maybe with the same filenames as in the extension directory)

Then run the script:

```shell
sudo ./install.sh
```

## How to use

You have to create the extension and then check if it works.

```pgsql
DROP EXTENSION IF EXISTS gevel;
CREATE EXTENSION gevel;
SELECT gist_print('name_of_your_gist_index');
```
