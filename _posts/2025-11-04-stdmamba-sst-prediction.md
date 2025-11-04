---
title: "成果分享 | 同济大学&复旦大学&香港理工：基于时空分解Mamba的长期细粒度海温预测方法 (IEEE TGRS)"
image: images/stdmamba-architecture.png
author: 01zhoushui
tags: research, publication, sst-prediction, mamba
---

 ADMIS 实验室近日在期刊IEEE Transactions on Geoscience and Remote Sensing (TGRS) 发表了关于时空数据预测领域的最新研究成果——基于时空分解Mamba的长期细粒度海温预测方法。本研究聚焦于海表温度（SST）的长期细粒度预测问题。现有方法大多仅能实现短期预测或长期粗粒度预测，难以同时应对海温序列中的噪声干扰与复杂时空依赖建模挑战。为突破这一瓶颈，我们提出了一种全新的时空分解Mamba模型STDMamba，用于长期精细化SST预测。

## 研究背景

长期细粒度海表温度预测能够提供对海洋气候模式的深入且详尽的理解。随着预测时间的延长，实现准确的长期细粒度海表温度预测方面面临两大挑战。首先，噪声干扰问题通常阻碍时间序列中有效模式的提取，即使微量噪声也可能导致提取模式发生显著变化。尤其在长期细粒度海表温度预测中，噪声干扰问题易因时间跨度延长而放大，使得提取可靠的海表温度变化模式变得困难。其次，现有海表温度预测模型难以捕捉长期精细化序列中的时空关联性。随着预测周期延长，这些模型往往仅能学习短期或粗粒度时空关联，导致其难以有效捕捉长期精细化的时空依赖关系。

## 方法介绍

我们提出一种时空分解Mamba模型STDMamba，该模型能够对长期海表温度序列进行降噪处理，并捕捉有效的时空相关性，从而实现精确的长期细粒度海表温度预测。具体而言我们设计了一个高斯加权序列分解模块，采用平滑策略来减轻长期精细尺度海表温度预测中的噪声干扰。该模块提取海表温度序列的波动和趋势分量，并利用趋势信息引导预测过程，从而有效抑制噪声干扰。接着，我们设计了双时空表示学习模块，通过基于Mamba2的双向表示学习和基于时序卷积网络（TCN）的表示学习，分别捕捉海表温度序列中波动分量与趋势分量中可靠的长期时空依赖关系。

![STDMamba方法总体框架](images/stdmamba-framework.png)
图1. STDMamba方法总体框架。

如图所示，高斯加权序列分解模块包含位置导向嵌入（以每个变量作为编码目标）与趋势分解。其中对于趋势分解，我们采用高斯加权高斯核进行时间序列分解，并引入高斯平滑技术，通过加权平均法降低噪声干扰。权重由高斯函数决定，中心位置权重较高，并随距中心距离增加而递减。既能平滑噪声，又能保留长期海表温度数据的关键特征。

双时空表示学习旨在学习波动分量与趋势分量的长期时空依赖关系。该模块针对波动分量和趋势分量的不同特点分别开发了基于Mamba2的双向表示学习和基于TCN的表示学习。我们所设计Mamba2的双向表示学习模块，突破了原Mamba块仅考虑序列中的历史时刻的单向特性，这限制了它只能学习正向时间依赖关系。为全面捕捉波动分量中复杂的长期依赖关系，我们基于 Mamba2 引入了正向与反向表征学习。而针对较为平稳的趋势分量，采用深度卷积和逐点卷积有效捕捉海表温度数据的长期趋势。

## 实验结果

我们通过两个真实世界数据集开展了广泛实验，评估STDMamba的有效性，并通过与多个强基准模型的对比验证了其卓越性能。

![表1](images/stdmamba-table1.png)
表1. STD Mamba 与七种基线长期预测模型在 NPO-SST 数据集上的性能比较，输入长度为 360，预测长度分别为 {30, 60, 90, 180, 270, 360}。加粗结果表示最优结果，带下划线的结果表示次优结果。我们的 STD Mamba 模型在所有预测长度下都取得了最佳预测性能。

![表2](images/stdmamba-table2.png)
表2. STD Mamba 与七种基线长期预测模型在 INO-SST 数据集上的性能比较，输入长度为 360，预测长度分别为 {30, 60, 90, 180, 270, 360}。加粗结果表示最优结果，带下划线的结果表示次优结果。我们的 STD Mamba 模型在所有预测长度下都取得了最佳预测性能。

![表3](images/stdmamba-table3.png)
表3. STD Mamba 及其变体的结果，其中结果为所有预测长度的平均值。

![图2](images/stdmamba-figure2.png)
图2. STD Mamba 与基线模型在NPO-SST 数据集上预测序列长度为 360 时，分别在第 90 天、第 180 天和第 360 天的整体 MAE结果，颜色越深表示预测误差越大。

![图3](images/stdmamba-figure3.png)
图3. STD Mamba 与基线模型在IPO-SST 数据集上预测序列长度为 360 时，分别在第 90 天、第 180 天和第 360 天的整体 MAE结果，颜色越深表示预测误差越大。

![表4](images/stdmamba-table4.png)
表4. STD Mamba、移动平均法（MA）和小波分解法（WD）在 NPO-SST 和 INO-SST 数据集上的分解质量比较。较低的 DTW 值表示趋势提取的质量更高，而较高的 Sim 得分表示波动提取效果更好。

## 发表情况

相关论文发表于中科院一区期刊IEEE TGRS。同济大学计算机科学与技术学院博士生蒋旭东和王淑玉为共同第一作者，同济大学计算机科学与技术学院李文根副教授和关佶红教授为共同通讯作者。

### 论文信息

Xudong Jiang, Shuyu Wang, Wengen Li,  Hanchen Yang, Jihong Guan,  Yichao Zhang, and Shuigeng Zhou. "STDMamba: Spatio-Temporal Decomposition Mamba for Long-Term Fine-Grained SST Prediction," in IEEE Transactions on Geoscience and Remote Sensing, doi: 10.1109/TGRS.2025.3624051.

### 论文代码

[https://github.com/XDjiang25/STDMamba](https://github.com/XDjiang25/STDMamba)

撰稿｜蒋旭东
排版｜彭　瀚
审核｜关佶红 李文根

![ ADMIS Lab](images/admis-lab-logo.png)
- 微信号: admis_lab
- 实验室网站: [admis-tongji.github.io](admis-tongji.github.io)
