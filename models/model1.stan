data {
  int<lower=0> num_cases;
  int<lower=0> num_judges;
  matrix[num_cases,num_judges] S;
}
parameters {
  vector[num_judges] h;
  real H;
}
model {
  vector[num_cases] t = (cosh(S*(H+h))/prod(cosh(H+h))) + (cosh(S*(H-h))/prod(cosh(H-h))) ;
  target += normal_lpdf( H | 0, 0.5 );
  target += normal_lpdf( h | 0, 0.5 );
  target += sum(log(0.5*t/pow(2,num_judges)));
}

