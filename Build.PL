use strict;
use Module::Build;

Module::Build->new(
    module_name => "Parse::Debian::Packages",
    license     => 'perl',
    requires    => {
        'Test::More'      => 0,
        'Module::Build'   => '0.18', # shabang line fixup
    },
    create_makefile_pl => 'passthrough',
   )
  ->create_build_script;
