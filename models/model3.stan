functions {
  matrix toSymMat( vector x, int M ) {
    matrix[M,M] ans = rep_matrix(0,M,M);
    for (i in 1:M) {
      for (j in 1:(i-1)) {
        ans[i,j] = x[((i-2)*(i-1))/2 + j];
        ans[j,i] = x[((i-2)*(i-1))/2 + j];
      }
    }
    return ans;
  }
  int powint( int x, int y ) {
    int ans = 1;
    for (i in 1:y) {
      ans = ans * x;
    }
    return ans;
  }
}
data {
  int<lower=0> num_cases;
  int<lower=0> num_judges;
  matrix[num_cases,num_judges] S;
}
transformed data {
  int N = powint(2,num_judges);
  matrix[N, num_judges] R;
  for (i in 0:(N - 1)) {
    for (j in 1:num_judges) {
      R[i + 1, j] = (i / powint(2,j-1) % 2) * 2 - 1;
    }
  }
}
parameters {
  vector[num_judges] h;
  real H;
  vector[(num_judges*(num_judges-1))/2] j;
}
transformed parameters {
  matrix[num_judges,num_judges] J = toSymMat(j, num_judges);
}
model {
  vector[N] RJR = rows_dot_product(R,(R * J)) / (2*sqrt(num_judges));
  vector[num_cases] SJS = rows_dot_product(S,(S * J)) / (2*sqrt(num_judges));
  real Z1 = sum(exp(RJR).*(exp(R*(H+h))+exp(-R*(H+h))));
  real Z2 = sum(exp(RJR).*(exp(R*(H-h))+exp(-R*(H-h))));
  vector[num_cases] c1 = 0.5*(exp(SJS).*(exp(S*(H+h))+exp(-S*(H+h))) / Z1);
  vector[num_cases] c2 = 0.5*(exp(SJS).*(exp(S*(H-h))+exp(-S*(H-h))) / Z2);

  target += normal_lpdf( h | 0, 0.5 );
  target += normal_lpdf( H | 0, 0.5 );
  target += normal_lpdf( j | 0, 0.5 );
  target += sum(log(c1+c2));
}

