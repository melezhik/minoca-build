my $target = config()->{target} || [];
my @targets;

if (ref $target eq 'ARRAY') {
  @targets = @{$target}
}else {
  @targets = split ',', $target;
}

for my $t (@targets) {

  if ( $t eq 'image' ){
    run_story('image');
    next;
  }

  if ( $t eq 'os' ){
    run_story('os');
    next;
  }

  if ( $t eq 'list' ){
    run_story('list');
    next;
  }

  ($target_safe_name = $target )=~s{/}[-]g;

  run_story('make', { target => $target, target_safe_name => $target_safe_name });

}

