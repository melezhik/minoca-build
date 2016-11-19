my $target = config()->{target} || [];
my @targets;

if (ref $target eq 'ARRAY') {

  @targets = map { [ /(.*?)-(.*)/ ] }  @{$target}

}else {

  @targets = map { [ /(.*?)-(.*)/ ] }  split ',', $target;

}

for my $t (@targets) {

  my $action = $t->[0];
  my $thing  = $t->[1];

  run_story($action, { thing => $thing })

}
