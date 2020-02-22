************************************
* Main Estimations for JOP Tables  *
* Author: Findley, Piazza, Young   *
* Project: Games Rivals Play JOP   *
* Date: March 26, 2013			   *
************************************ 

*******************************************************************************
* Errata Note 																  *
* Due to a data management error, some observations were missing from the     * 
* 1968-2002 period reported in JOP. 								          *
*																			  *
* The data contained here include the full 1968-2002 period with the models   *
* estimated exactly the same way as they were in the JOP paper. The raw       *      
* results (coefficients, standard errors, p-values) are of course different   *
* than what is reported in the print version. However, all of the results for * 
* rivalry remain substantively the same (same sign; statistically significant)* 
* In some cases, the results are stronger than those reported in the JOP paper*
*																			  *
* We produce new results and report them in the companion document titled:    *
* "JOP-Results-Errata.doc  										     	      *
*******************************************************************************

use "fpy replication data jop 2012.dta"
set more off

******************
* Table 1        *
******************

/* Table 1, Model 1*/

#nbreg is Stata syntax for a negative binomial regression. 

#It looks like to run a regression and make a table in Stata, all you have to do is drag and drop variables in a pile of sorts. This seems very intuitive- Table 1, Model 1 analyzes Terror Counts (terrorCounts below) and rivalry, joint democracy, the log of capability ratio, and contiguity. 

#I am quite curious as to how they calculated the log variable- do you just type log in front of whatever you want to take the log of? I need to develop Stata skills, obviously. 

nbreg terrorCounts rivalry jointDem1 logcapratio contiguity, nolog cluster(dyadid) dispersion(constant) 

/*Table 1, Model 2 */

#All of these tables are the same- the authors just dragged and dropped the variables they wanted to analyze and they incorporated them into a table. 

nbreg terrorCounts2 rivalry jointDem1 logcapratio contiguity, nolog cluster(dyadid)  dispersion(constant) 

/*Table 1, Model 3 */
nbreg terrorCounts rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, nolog cluster(dyadid) dispersion(constant) 

/*Table 1, Model 4 */
nbreg terrorCounts2 rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, nolog cluster(dyadid)  dispersion(constant) 


********************
* Table 2          *
********************

/* Table 2, Model 5 */

#zinb is how Stata calculates a zero-inflated negative binomial regression. The authors decided to do this to account for the large number of terror attacks that DON'T happen. The methods appear to be the same as they were in Table 1 regarding how the authors coded everything in. 

zinb terrorCounts rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, inflate(rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2) cluster(dyadid) nolog 

/* Table 2, Model 6 */
zinb terrorCounts2 rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, inflate(rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2) cluster(dyadid) nolog

/* Table 2, Model 7 */
/* Note: convergence issues require a different maximization technique (bfgs) */
zinb terrorCounts rivalry jointDem1 logcapratio historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, inflate(jointDem1) cluster(dyadid)  technique(bfgs) nolog

/* Table 2, Model 8 */
zinb terrorCounts2 rivalry jointDem1 logcapratio  historyl1 historyl2 coldwar1 conflict1 conflict2 contiguity war1 war2, inflate(jointDem1) cluster(dyadid) nolog

#Overall, this paper seems doable to reproduce in R. Stata seems very intuitive, if not a little old and clunky. I am a little concerned that some code is missing, but this may just be how Stata works. 

