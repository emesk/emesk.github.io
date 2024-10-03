---
layout: archive
title: "Projects in Progress"
permalink: /projects_in_progress/
author_profile: true
redirect_from:
  - /projects_in_progress
---
<b><u>Industrial Supported BS and MS Theses</u></b>

1. **Decentralized AI on Edge IoT based network for illegal wood cutting detection in forests based on Tiny ML**.  
A team of 5 students are working on this project. It has the following parts: training of ML model based on the dataset containing audio files for the wood cutting, traffic, wildlife and related sounds. The target is to identify the wood cutting activity using a microphone array. Each node contains a trained ML model that listens to the sound in a low power consumption mode. As soon as the wood cutting activity is detected, it communicates in the cluster to the neighbouring nodes to verify. Once verified, the adhoc network alers the nodes in a tree structure along with the sound signature/sample sound data to the master node. This project involves dataset analysis and preparation, ML model training and fine tuning, deployment on low power microcontrollers using Tensorflow Lite, a network of nodes communicating using LoRA WAN or alternate technology a false positive detection algorithm. 

2. **Federated Learning for Power System Optimization**  
This project uses federated learning to exchange flexibility in the power grid while maintaining the privacy of the individual models.
Currently two students are working on this project.

3. **HVAC Predictive maintenance**  
Together with National center for Physics, Pakistan, this project aims to model the air processor with focus on the typical faults encountered in this system. The target is to locate the potential faults in the sub-components with help from sensor data early on as part of predictive maintenance algorithm.

4. **MLOps platform engineering**  
This project is currently in progress to deploy a MLOps platform on a Kubernetes cluster setup providing end to end development solution to the students/faculty at the univeristy. The emphasis is one the scalability and easy access to workspaces to facilitate teacher-student interactions. The platform shall possess intergration capabilities with the gitlab and API calls for the external partners. The MLOps platform shall provide 1200 GPU cores, 3.7 TiB RAM (600 GB of GPU RAM, 200 V100S).

5. **Proxmox based Hypervisor for Scalable VM based Solutions**  
This project is recently deployed to provide a HPC platform with the following specifications: 2352 CPU(s), 5.37 TiB RAM, 700 TiB Disk Space for data lake applications

**Sybrid**
**Title: Development of Embedding Models for Local Languages (Urdu, Punjabi, Pashto, Sindhi)**

**Title: Speech to Text – Fine-tuning for Pashto**

Automatic Speech Recognition (ASR), also known as Speech to Text (STT), has evolved significantly with the development of systems such as Whisper by OpenAI and MMS by Meta. However, these systems face limitations, especially when applied to less represented languages like Pashto, particularly in areas such as vocabulary and accent recognition. This thesis aims to fine-tune existing STT models, specifically for Pashto and its dialects, with a focus on enhancing recognition for specialized vocabulary related to the agriculture sector and improving performance for rural accents.
The project will involve the addition of missing domain-specific vocabulary to the models, followed by fine-tuning to lower Word Error Rates (WER) in challenging contexts such as strong accents. The final stage includes model pruning to ensure the system can run efficiently on CPU-based systems, making it accessible for users with limited computational resources.
The expected outcome is a fine-tuned Pashto ASR system that improves WER by at least 10% for agricultural terminology. This thesis will contribute to more effective speech recognition for regional languages, particularly for specialized and underrepresented domains.
[More details](http://emesk.github.io/files/sybrid_Speech_to_Text_Finetuning_for_Pashto.pdf.pdf)









