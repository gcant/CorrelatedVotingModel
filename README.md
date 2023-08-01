# Correlated Voting Models

rstan code for fitting the models from **Valence in a statistical mechanics of voting**.

To reproduce model fits from the paper, run 
```
Rscript run_all_fits.r
```

In general, one can run:
```
S = read.csv('myData.csv', header=FALSE)
fit_all_models(S, "myData")
```
where ```myData.csv``` is a csv of +/-1's and each row corresponds to a different case.

The data ```synthetic.csv``` is generated from the model without interactions, and so the model likelihood (correctly) picks *model 1*.

Models 1, 2, and 3 are defined as below.

### Model 1
$$ P( \boldsymbol{s} \vert H, \boldsymbol{h} ) = \frac{1}{2} \left( 
\frac{\cosh(\sum_i (H+h_i)s_i )}{ \prod_{i} 2 \cosh(H+h_i) } 
+
\frac{\cosh(\sum_i (H - h_i)s_i )}{ \prod_{i} 2 \cosh(H - h_i) } 
\right)
$$

### Model 2
$$ P( \boldsymbol{s} \vert J ) = \frac{1}{Z}
\exp \Big( {\textstyle \sum_{i < j}} J_{ij} s_i s_j / \sqrt{n} \Big)
$$

### Model 3
$$ P( \boldsymbol{s} \vert H, \boldsymbol{h}, J ) = \frac{\exp \big( {\textstyle \sum_{i < j}} J_{ij} s_i s_j / \sqrt{n} \big)}{Z} \left( 
\frac{\cosh(\sum_i (H+h_i)s_i )}{ \prod_{i} 2 \cosh(H+h_i) } 
+
\frac{\cosh(\sum_i (H - h_i)s_i )}{ \prod_{i} 2 \cosh(H - h_i) } 
\right)
$$
