my $target = config()->{target} || [];
my @targets;

if (ref $target eq 'ARRAY') {

  @targets = map { [ /(.*?)-(.*)/ ] }  @{$target}

}else {

  if ($target eq 'build-os'){
    run_story('build-os');
    exit;
  } elsif ( $target eq 'build-image' ){
    run_story('build-image');
    exit;
  } elsif( $target eq 'list' ) {
    run_story('list-targets');
    exit;
  } else {
    @targets = map { [ /(.*?)-(.*)/ ] }  split ',', $target;
  }

}

my $need_copy=0;

for my $t (@targets) {

  my $action = $t->[0];
  my $thing  = $t->[1];

  $need_copy=1 if $action eq 'build';

  run_story($action, { thing => $thing })

}

run_story('copy') if $need_copy; # update apps/ directory with built packages if need
