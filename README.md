# Artificial Intelligence & Optimization Projects (MATLAB)

This repository contains a collection of projects from my university focused on Artificial Intelligence, Neural Networks, and Evolutionary Optimization Algorithms, all implemented in MATLAB.

## Project Structure

### 1. Evolutionary Algorithms & Optimization
Focused on finding global minima for complex functions and solving discrete optimization problems using heuristic approaches.
* **Function Optimization:** Implementation of Genetic Algorithms (GA) for Schwefel and Eggholder functions.
* **Traveling Salesman Problem (TSP):** Solving path optimization using evolutionary techniques.
* **Hill Climbing:** Comparison of classic and stochastic hill-climbing algorithms.

### 2. Medical Data Classification (MLP)
Utilizing Multi-Layer Perceptron (MLP) networks for classification and function approximation.
* **Cardiotocography (CTG) Data:** Classifying medical records into three diagnostic classes (Normal, Suspect, Pathologic).
* **3.D Point Classification:** Spatial data classification and non-linear function approximation.

### 3. Image Classification (CNN)
Deep Learning approach for recognizing hand-written digits (MNIST-style dataset).
* **CNN vs. MLP:** Performance comparison between Convolutional Neural Networks and standard Feed-Forward networks.
* **Architecture Tuning:** Testing various layer configurations and training parameters.

---

## Authorship and Credits
The core logic, network architectures, parameter tuning, and final implementations of the tasks are my original work.

**Notice:** Certain utility functions and genetic operators (e.g., `selbest.m`, `genrpop.m`, `crossov.m`, `swappart.m` or visualization scripts like `dispznak.m`) were provided by the university as part of the course materials. These helper scripts are the intellectual property of their respective authors, as noted in the file headers.

## Requirements
* MATLAB (R2021a or newer)
* Deep Learning Toolbox
* Optimization Toolbox
