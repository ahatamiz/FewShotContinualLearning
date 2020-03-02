# Task Specification

## Task Definition

A continual few-shot learning task consists of a number of (training) support sets and a single (evaluation) target set.

The support sets are controlled by the following hyperparameters:

1. Number of Support Sets (**NSS**): The number of support sets within a continual task.
2. Number of Classes Per Support Set (**N**): The number of classes within each support set.
3. Number of Samples Per Support Set Class (**K**): The number of data-points to be sampled for each class in the support set.
4. Number of Samples Per Target Set Class (**J**): The number of data-points to be sampled for each class in the target set. The number of classes in a target set is given by  $\dfrac{NSS\times N}{CCI}$
5. Class Change Interval (**CCI**): Assuming a task has NSS support sets, CCI defines the number of support sets 
sampled with the same class source, before that class source is resampled. This allows fine control of the type of task that will be generated.
6. Overwrite: A boolean variable that describes whether classes sampled at each support set will overwrite the class labels of the previously sampled support set (TRUE), or whether they will assigned new unique labels (FALSE).
For example, if support set 0 has class labels 0, 1, 2, 3, 4, then 
```
if Overwrite==FALSE: 
    support set 1 class labels: 5, 6, 7, 8, 9
elif Overwrite==TRUE:
    support set 1 class labels: 0, 1, 2, 3, 4
```
## Data Flow Dynamics

1. The model can only access one support set at a time for the purposes of knowledge extraction. 
Once this extraction is completed, the current support set is deleted. 
2. Task knowledge can be stored within a parameter vector/matrix or an embedding vector/matrix.
3. Once knowledge has been extracted by all the support sets, the model is tasked with predicting the classes of 
previously unseen samples. A generalization measure can be obtained by using the labels of this said, once the model
 has produced its predictions to compute a task-level generalization measure.
 
## Metrics

1. Test Generalization Performance: A proposed model should be evaluated on the test sets of Omniglot and SlimageNet, on all of the task
types of interest. This is done by presenting the model with a number of previously unseen continual tasks sampled from these test sets, and then
using the target set metrics as the task-level generalization metrics. To obtain a measure of generalization across the whole test set the model
should be evaluated on 600 unique tasks and then take the mean and standard deviation of both the accuracy and cross-entropy performance of the model.
These should be used as generalization measures to compare the model to other models.

2. Across-Task Memory (ATM): Since the knowledge storage vectors that store support set knowledge have unrestricted memory, we also incorporate
a metric that explicitly measures how memory efficient a certain model is, which can help differentiate between models of equal generalization performance.
This measure can be computed by $\dfrac{M}{T}$ where *M* is the total knowledge memory size across a whole task, and 
*T* is the total size of all samples in all the support sets within a task.  