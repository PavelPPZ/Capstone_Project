CAPSTONE PROJECT

# Introduction
In many applications or devices when we type the text there is the option to suggest the next word providing several options. Sometimes it helps, sometimes it makes you crazy …
If we imagine ourselves predicting next word based on previous input words, we understand that it is enormously difficult task. 
“my dog is ….” (running, jumping, sleeping …?), “he is a …” (driver, husband, boy …?) Really hard to make decision!
Two important things that are clear from mental simulation of words prediction
- The longer is the input line of words the better is the prediction: it is impossible to predict reasonably based on 1-2 words, 3-4 words input is the limit when your prediction starts to make sense.
- Probability of prediction of one specific word is not high, you always have in mind 5-10 words that match the input text.

# Overview
The objective of the project is to build the model that predicts the next word based on previous input text and realize it in Shiny application.
In the course of the project, we will compare 2 popular word prediction models (backoff and interpolation) and analyze their performance for different volumes of training data.
Based on this analysis the most efficient solution will be chosen and implemented in the form of Shiny application.

# Project details
Parts 1 and 2 https://rpubs.com/pzakharo0/1172855
Parts 3 and 4 (https://rubs.com/pzakharo0/1172837

# Demonstration application
Shiny application - word prediction
https://pavelppz.shinyapps.io/Capstone_project_word_prediction

# GitHub link
https://github.com/PavelPPZ/Capstone_Project

# Summary
Based on the results of analysis the most efficient model for word prediction out of considered ones (backoff and interpolation) is the simple **backoff model based on adjusted training Ngrams** (N = 1-4, adjustment approach: for N >1 keep only Ngrams with word count > 1). 
The total volume of adjusted Ngrams is less than 20MB. Computation for backoff model is simple and efficient. Both parameters are aligned with the requirements to prediction model for mobile devices.
The accuracy of prediction of the 4th word based on previous 3 words is about **12-13%**. This is aligned with the “mental simulation”. If you are given 3 words you can provide 5-10 reasonable options of the 4th word to continue.
One of the possible optimization solutions is to provide **several predicted words** with the highest probability. Provision of the list of 5-10 most probable words would increase the prediction accuracy to reasonable levels (35%+) while still keeping the application handy in use and “light” in terms of resources. From this perspective N-gram model is a good “light-weight” word prediction solution.
Further **substantial increase** of the quality of word prediction can’t be achieved within N-gram framework. Different N-gram models can vary in performance but all them are limited with N-gram “key-hole” view based on sequence of N words only. 
Substantial progress in word prediction requires to take into account the **wider context**: consider the topic of discussion; analyse statements and possible conclusions; identify words that indicate probable outcome; use skip-grams (non-adjacent occurrences); track inter-relations  … Here we are stepping into the area of generative AI and LLMs that is beyond the scope of current project.
