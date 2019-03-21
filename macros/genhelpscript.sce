//=============================================================================
// bytecode_edupack - Bytecode Education Pack Module
// Copyright (C) 2019  Bytecode
//=============================================================================

current_path = pwd();
current_path = get_absolute_file_path("genhelpscript.sce");
path_macros = fullpath(current_path) + filesep();

p1Help = fullpath(current_path + '/../help/en_US');

all_scifile = ls(path_macros+'*.sci');

for cnt = 1:size(all_scifile,1)
    help_from_sci(all_scifile(cnt), p1Help);
end

