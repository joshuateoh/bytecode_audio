// This file is released under the 3-clause BSD license. See COPYING-BSD.
// Generated by builder.sce: Please, do not edit this file.
// ------------------------------------------------------
curdir = pwd();
scriptdir = get_file_path('cleaner.sce');
chdir(scriptdir);
// ------------------------------------------------------
if fileinfo('loader.sce') <> [] then
    mdelete('loader.sce');
end
// ------------------------------------------------------
jarFilePath = fullfile(scriptdir, '..\..\jar\com.bytecode_asia.jar');
if fileinfo(jarFilePath) <> [] then
    mdelete(jarFilePath);
end
// ------------------------------------------------------
chdir(curdir);
clear curdir;
