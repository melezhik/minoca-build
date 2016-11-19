my @targets;

if (config()->{action}){
  @targets = map { /(.*?)-(.*)/ and [ $1, $2 ] } , split ',', @{config()->{action}}

}else{

}

for my $action (){
}
