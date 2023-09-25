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
To reproduce model fits from the paper, run in bash
```bash
Rscript run_all_fits.r
```
or from within the R-terminal
```R
source('run_all_fits.r')
```

For any specific data set, one can run
```R
S = read.csv('myData.csv', header=FALSE)
fit_all_models(S, "myData")
```
where ```myData.csv``` is a csv of +/-1's and each row corresponds to a different case and
"myData" is the name of the models. The model parameters are saved into CSV files into the
```out``` directory. 

The data ```synthetic.csv``` is generated from the model without interactions, and so the
model evidence (correctly) picks *model 1*.  We also provide the voting data for the
Second Rehnquist Court and the Roberts Court as ```rehnquist1607.csv``` and
```roberts1709.csv``` for reproduction. The corresponding justice initials are in
```rehnquist1607_initials.txt``` and ```roberts1709_initials.txt```. These have been taken from the
[SCDB](http://scdb.wustl.edu) Version 01 from 2022 and the four digit suffix is the
[natural court identifier](http://scdb.wustl.edu/documentation.php?var=naturalCourt).


### Compiled output
Individual fields from model 3 are in the CSV file ```analysis/h_i.csv```. This can be
read in R using
```R
df_read <- read.csv("analysis/h_i.csv", row.names = 1)
```
and in Python using pandas
```python
df = pd.read_csv('analysis/h_i.csv', index_col=0)
```
The column named ```H``` is the unanimity field.

Note that there is ambiguity with respect to the sign of the individual field, so we have
oriented unanimity field H to be positive.

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
