so $VIMRUNTIME/syntax/perl.vim
syn match perlSQLNOCACHEError "SQL_NO_CACHE$"
syn cluster perlInterpDQ add=perlSQLNOCACHEError
syn cluster perlInterpSQ add=perlSQLNOCACHEError
hi def link perlSQLNOCACHEError Error
