# Correlated Voting Models

rstan code for fitting the models from **Valence in a statistical mechanics of voting**.

### Setup
To setup the code, first install rstan
```R
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
```
Then import the necessary functions
```R
library(rstan)
source("fitting_fns.r")
```

### Running
To reproduce model fits from the paper, run 
```R
Rscript run_all_fits.r
```

In general, one can run:
```R
S = read.csv('myData.csv', header=FALSE)
fit_all_models(S, "myData")
```
where ```myData.csv``` is a csv of +/-1's and each row corresponds to a different case.

The data ```synthetic.csv``` is generated from the model without interactions, and so the model evidence (correctly) picks *model 1*.
We also provide the voting data for the Second Rehnquist Court and the Roberts Court as ```rehnquist.csv```
and ```roberts.csv``` for reproduction. These have been taken from the [SCDB](http://scdb.wustl.edu) Version 01 from 2022.


### Equations
Models 1, 2, and 3 are defined as below.

#### Model 1
$$ P( \boldsymbol{s} \vert H, \boldsymbol{h} ) = \frac{1}{2} \left( 
\frac{\cosh(\sum_i (H+h_i)s_i )}{ \prod_{i} 2 \cosh(H+h_i) } 
+
\frac{\cosh(\sum_i (H - h_i)s_i )}{ \prod_{i} 2 \cosh(H - h_i) } 
\right)
$$

#### Model 2
$$ P( \boldsymbol{s} \vert J ) = \frac{1}{Z}
\exp \Big( {\textstyle \sum_{i < j}} J_{ij} s_i s_j / \sqrt{n} \Big)
$$

#### Model 3
$$ P( \boldsymbol{s} \vert H, \boldsymbol{h}, J ) =  \exp \big( {\textstyle \sum_{i < j}} J_{ij} s_i s_j / \sqrt{n} \big) \left( 
\frac{\cosh(\sum_i (H+h_i)s_i )}{ Z_1 }  + \frac{\cosh(\sum_i (H - h_i)s_i )}{ Z_2 } \right)
$$
