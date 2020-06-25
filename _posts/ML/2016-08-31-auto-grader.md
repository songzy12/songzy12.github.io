---
layout: post
title: "AutoGrader"
date: 2016-08-31 20:49:10 +0800
comments: true
categories: 

---


```
Total nSV = 2912
Cross Validation Accuracy = 36.4568499003133%
```
```
Total nSV = 2143
Cross Validation Accuracy = 27.745424292845257%
```

```
select run_info from pt_user_challenge_compile ucc, pt_user_challenge uc, pt_challenge c where c.challenge_id = uc.challenge_id and uc.user_challenge_id = ucc.user_challenge_id and c.direction  = 4 and ucc.status_code = 1 limit 1;
```

## features
* costTime, countDown, level 
* focusBlurCount, avgSwitchTime, blurCount, avgBlurTime, 
* editCount, avgEditDuation, intervalCount, avgIntervalDuration, avgTextLength,
* compileCount, compileFailCount, avgCodeLength, avgContinousCompileDuration, avgContinousFailCount, avgContinousCompileFailDuration, avgCompileDuration (4)
* direction, compileErrorNum, averageCompileErrorNum


* addCostTimeFeature(features, userChallengeId);
* addFocusBlurFeature(features, userChallengeId);
* addTextFlowFeature(features, userChallengeId);
* addCompileFeature(features, userChallengeId);
* addCompileErrorNumFeature(features, userChallengeId);

## svm_scale

The main advantage of scaling is to avoid attributes in greater numeric ranges dominating those in smaller numeric ranges. Another advantage is to avoid numerical diculties during the calculation. Because kernel values usually depend on the inner products of feature vectors, e.g. the linear kernel and the polynomial ker- nel, large attribute values might cause numerical problems. We recommend linearly scaling each attribute to the range [-1,+1] or [0,1].

* the min and max of each feature is stored by `-s` option.
* modify the method `output`, `output_target` to store scaled feature into file.

## libsvm

[libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm/), [github](https://github.com/cjlin1/libsvm).

* Trainer: svm_train.main(crossValidationTrainArgs);
* Predictor: svm_predict.main(testArgs); 

```
-s svm_type : set type of SVM (default 0)
	0 -- C-SVC		(multi-class classification)
	1 -- nu-SVC		(multi-class classification)
	2 -- one-class SVM	
	3 -- epsilon-SVR	(regression)
	4 -- nu-SVR		(regression)
-t kernel_type : set type of kernel function (default 2)
	0 -- linear: u'*v
	1 -- polynomial: (gamma*u'*v + coef0)^degree
	2 -- radial basis function: exp(-gamma*|u-v|^2)
	3 -- sigmoid: tanh(gamma*u'*v + coef0)
	4 -- precomputed kernel (kernel values in training_set_file)
-v n: n-fold cross validation mode
```

* c-svc中c的范围是1到正无穷
* nu-svc中nu的范围是0到1

nu是错分样本所占比例的上界，支持向量所占比列的下界。

* Least squares SVR: use squared residuals in the cost function
* ep-SVR or nu-SVR: use hinge loss in the cost function

* nu-SVR: proportion of number of support vectors.
* ep-SVR: error you will allow your model to have.

## compile time errors

[Predicting Performance in an Introductory Programming Course by Logging and Analyzing Student Programming Behavior.]

Group the resolve time into 7 distinct classes of error(syntax, computation, identifiers, scope, exceptions, inheritance, abstraction).

[BlueFix: Using Crowd-Sourced Feedback to Support Programming Students in Error Diagnosis and Repair]

Classification of Java Compile Time Errors:

* syntax(; expected): violate te fundamental syntax rules of Java
* computation(illegal operations): program logic definition, flow control
* identifiers(unknown method): unknown, re-declaring variables/method
* scope(method is private): access violation: public, private, packages
* exceptions(try without a catch): error handling, try-catch keywords
* inheritance(super-type not called): method/variable overriding, super
* abstract(cannot have body): misuse of abstract keyword
* static(cannot be referenced): related to use of class and object types

## mysql

```
mysql -u guest -p # guest
use oxcoder;
show tables;
describe pt_user;
show columns from user;
```

## dependency finder

[Here](https://sourceforge.net/projects/depfind/?source=typ_redirect).

`~/.profile`

```
export JAVA_HOME=/usr
export DEPENDENCYFINDER_HOME=$HOME/DependencyFinder-1.2.1-beta4
export DEPENDENCYFINDER_OPTS=-Xmx128m
export PATH=$DEPENDENCYFINDER_HOME/bin:$PATH
```

## algorithm design

* unrelated: 1
* keywords: 2
--- compilable
* control structures: 3
* data dependencies: 4
--- pass test case
* correct: 5
