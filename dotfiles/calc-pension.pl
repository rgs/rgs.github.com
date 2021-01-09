#!/usr/bin/perl
# 1er janvier de chaque année, dernier indice paru
# indice mensuel des prix à la consommation des ménages (INSEE)
# (serie hors tabac ensemble des ménages)

use 5.010;
use strict;
use warnings;

# Depuis le 29 janvier 2016, cet indice est déterminé en référence à l'année
# 2015 et non plus à l'année 1998 comme auparavant
#
my $pension_init = 858.87; # 2015
my %indice = (
    2016 => 100.36, # Nov. 2016
    2017 => 101.47, # Nov. 2017
    2018 => 103.14, # Nov. 2018
    2019 => 103.92, # Nov. 2019
    2020 => 103.86, # Nov. 2020
);
say $_, ": ", $pension_init * $indice{$_} / $indice{2016} for sort keys %indice;

# Ancienne version:
#my $pension_init = 800;
#my %indice = (
#    2009 => 117.13, # Janvier
#    2010 => 120.09, # Nov. 2010
#    2011 => 123.00, # Nov. 2011
#    2012 => 124.51, # Nov. 2012
#    2013 => 125.38, # Nov. 2013
#    2014 => 125.51, # Nov. 2014
#    2015 => 125.75, # Nov. 2015
#);

