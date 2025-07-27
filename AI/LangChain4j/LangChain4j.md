# 第01章_AI简介

## 1. AI发展史

AI，全名叫Artificial Intelligence，翻译过来就是人工智能，它的本意是让机器能够像人类一样思考、学习和解决问题。

人工智能最早可以追溯到1950年的图灵测试，图灵测试中有两种角色：被测试者和测试者，其中被测试者又分为机器和真人。测试者和被测试者通过文本进行沟通，在真实测试中，被测试者和测试者分别处在不同的房间中，这样测试者无法事先知道被测试者是人还是机器。在沟通的过程中，测试者需要根据接收到的文本信息，判断发送该文本信息的是机器还是人。假设机器给测试者发送了一段文本，但测试者判断的答案是人，这就说明测试者无法分辨清楚机器与人。这个时候，我们就可以说机器具有了人的智能。

人工智能的发展历程主要经过了三个阶段：符号主义、连接主义、神经网络。

### 1.1 符号主义

符号主义的特点是基于逻辑和规则，使用符号表示知识和推理。符号主义实现人工智能，主要分为三个步骤：

1. 首先**将现实抽象为符号**，比如把"天晴"记为A，"打篮球"记为B，"打游戏"记为C
2. 其次是**设置规则**，比如设置规则为"如果A，则执行B，否则执行C"
3. 最后**按照规则执行**

符号主义就相当于一个if-else语句。很明显，符号主义的一个致命缺点就是事实上我们很难把现实世界中的万事万物都抽象成具体的符号。

### 1.2 连接主义

我们可以通过模拟人脑的方式实现人工智能，于是罗森布拉特提出了著名的**感知机模型**，用于模拟神经元。在感知机模型中，输入类比神经元的树突、权重类比神经元的连接强度、激活函数类比神经元的突触。假设输入和激活函数都不变的情况下，我们可以通过调整权重值，得到不同的输出。这就是连接主义。

例如想设计一个感知机用于识别水果，我们就可以把水果的颜色、形状、味道等特征提取出来，作为感知机的输入；同时我们可以根据需求，给不同的特征取值设置不同的权重，例如我们要识别香蕉，此时可以给黄色、长条、甜的这三个特征设置权重为1，其它特征设置权重为0。结合输入和对应的权重以及激活函数，我们可以计算出一个分数，假设我们设定阈值为3，如果计算的总分达到3，我们就认为输入特征对应的水果就是香蕉，否则不是香蕉。

![image-20250705162731296](images/image-20250705162731296.png)

### 1.3 神经网络

上述的感知机模型只能做一些简单的是或不是的二分类任务，对于复杂的任务它就束手无策了。所以人们又发明了多层感知机模型，它就是由多个感知机叠加而来，每一层感知机都可以对输入的信息做整合处理并输出，输出的结果又作为下一层感知机的输入，这样层层传递得到最终的输出。

理论上，只要多层感知机模型足够宽足够深，就能够解决足够复杂的任务，这正是神经网络的由来。现在我们所接触的AI，也都是在这个基础上发展而来的。

![image-20250705163234985](images/image-20250705163234985.png)

## 2. 大模型

### 2.1 简介

每个感知机会结合用户的输入、权重、激活函数，与阈值进行比较，得到最终的输出。其中，阈值更专业的名称叫做**偏置**。每个神经元上使用的权重和偏置，我们称之为**参数**。因此，每个神经元上的`参数数量=权重数量+1`，这里的1就是偏置。

整个神经网络中的参数特别特别多，所以我们无法去手动设置这么多的参数。因此我们会通过一个软件去实现神经网络，我们事先准备好一些数据交给这个软件，让它根据我们提供的数据进行学习并自主地设置好神经网络中需要的成千上万的参数。在AI领域，我们将这个实现了神经网络的软件称为**模型**。

OpenAI公司有一个出名的模型叫做GPT，研发人员通过将参数规模从10B提高到100B（1B就是10亿），从而使得GPT模型展现出了通用任务的处理能力。现在，我们通常会把参数规模在1000亿以上的模型，称为**大模型**。

随着GPT模型的爆火，全球各大公司也纷纷跟进，推出了自己的大模型，比如智普AI的ChatGLM，阿里的Qwen，百度的Ernie，Anthropic公司的Cloude，元宇宙的Llma，马斯克的Grok等。不同公司的不同模型，也有不同的擅长领域，比如文本生成、图片生成、视频生成、音频合成、音频理解、视频理解、图片处理、语音识别等等。

### 2.2 特点

大模型有以下特点（这也是GPT名字的由来）：

- Generative（生成式）：根据上下文预测之后应该出现哪个文本，从而形成连续的文本输出
- Pre-trained（预训练）：通过大规模的文本数据进行预训练，让大模型可以理解人类语言的语法、词性
- Transformer：深度学习的一种神经网络模型，多数AIGC模型都依赖于此

### 2.3 Transformer

深度学习领域的自然语言处理（Natural Language Processing，NLP）有一个关键技术叫做Transformer，这是一种由多层感知机组成的神经网络模型，是现如今AI高速发展的最主要原因。我们所熟知的大模型如GPT、DeepSeek等底层都是采用Transformer神经网络模型。

Transformer是由Google在2017年提出的一种神经网络模型，它最初的作用是用于机器翻译。Transformer中提出的**注意力机制**使得神经网络在处理信息时可以根据上下内容调整对数据的理解，变得更加智能化。这不仅仅是说人类的文字，包括图片、音频数据都可以交给Transformer来处理。

而大语言模型是对Transformer的另一种用法：**推理预测**。LLM在训练Transformer时会尝试输入一些文本、音频、图片等信息，然后让Transformer推理接下来跟着的应该是什么内容，推理的结果会以**概率分布**的形式出现。当LLM根据前文推测出下一个词语后，就会把这个词语加入前文，然后继续推测下一个词语，不断重复该过程，就实现了持续生成的效果。

![image-20250726121322853](images/image-20250726121322853.png)

## 3. AI市场分布

目前AI主要分为三个赛道：基础算力、核心算法、智能应用。

### 3.1 基础算力

基础算力，就是为大模型提供计算能力。通常都是英伟达、微软、阿里等超大公司参与这个赛道，它们通过芯片、云计算等来为大模型提供更强的算力。

### 3.2 核心算法

这个赛道主要研究开发大模型所需要的算法以及算法框架，比如Transformer、pytoch、Tensorflow等等，其中比较知名的公司有OpenAI、深度求索、Meta、Google等等。

### 3.3 智能应用

参与这个赛道的人是最多的，通过借助大模型的能力来将各行各业的软件进行智能化的升级和改造，比如零售、旅游、金融等等。

大模型本质上是一个实现了一些数学模型的软件，对于普通人而言是无法直接使用的。如果我们要对传统的软件做智能化升级改造，我们就需要将大模型接入到传统的软件中，借助于大模型的能力，让软件的功能变得更强大更智能，这就是所谓的智能应用。

智能应用的常见领域有：

![image-20250726145426491](images/image-20250726145426491.png)

## 4. 智能体

OpenAI的元老翁丽莲于2023年6月在个人博客首次提出了现代AI Agent架构。**智能体（AI Agent）**是一种能够自主行动、感知环境、做出决策并与环境交互的计算机系统或实体，通常依赖大型语言模型作为其核心决策和处理单元，具备独立思考、调用工具去逐步完成给定目标的能力。智能体的架构如下：

![image-20250725210924835](images/image-20250725210924835.png)

智能体的核心要素：

- 大模型：LLM是AI Agent的决策中枢，提供推理、规划和知识理解能力。
- 记忆：**短期记忆**指的是存储单次对话周期的上下文信息，属于临时信息存储机制，受限于模型的上下文窗口长度；**长期记忆**指的是可以横跨多个任务或时间周期，可存储并调用核心知识，非即时任务，长期记忆可以通过模型参数微调（固化知识）、知识图谱（结构化语义网络）、向量数据库（相似性检索）等方式实现。
- 工具：通过调用外部工具（如API、数据库等）来扩展能力边界。
- 规划决策：通过任务分解、反思与自省框架实现复杂任务处理。例如，利用**思维链（Chain of Thought）**将目标拆解为子任务，并通过反馈优化策略。
- 行动：实际执行决策的模块，涵盖软件接口操作和物理交互。比如，检索、推理、编程等。

智能体发展至今经历过三个阶段：

1. **提示词立人设**：通过提示词设定角色，可以实现一个极其简易的智能体，来直接与LLM交互。例如Cherry-Studio、豆包等。
2. **工作流**：工作流是为完成某项任务而设计的一系列自动化步骤的有序组合，通过定义工作流，应用就会按照我们设定的流程执行任务。例如，Coze、Dify平台都支持创建工作流。
3. **real智能体**：智能体能根据人类设定的目标，自主进行任务拆分、工具选择、进度控制等，实现目标后自主结束工作。例如，Coze、Dify平台都支持创建这样的高阶智能体。

> 普通用户可以通过Coze、Dify等平台直接搭建高阶智能体，但对于我们程序员来说，往往希望能够做到更加的定制化，因此我们更倾向于采用编码的方式，使用Spring AI或LangChain4j等框架来搭建智能体。



# 第02章_大模型的基本使用

使用大模型，其实就是通过访问大模型对外暴露的API接口，实现与大模型的交互。

## 1. 大模型部署

企业首先需要有一个可访问的大模型，通常有两种选择：

1. 在本地服务器或云服务器上部署私有大模型
2. 在提供大模型服务的云平台上，访问开放的大模型API

> 说明：对于公司而言，会倾向于使用第一种方式来部署私有大模型，因为数据更加安全；而对于我们个人开发而言，会倾向于采用第二种方式，更加便捷。

### 1.1 服务器部署大模型

我们可以在服务器（本地服务器或云服务器）上部署大模型并使用，Ollama工具为我们提供了一键下载并运行大模型的功能，所以我们使用Ollama来部署大模型。

（1）前往官网 https://ollama.com/ 下载安装Ollama

（2）从官网 https://ollama.com/search 选择一个想要的大模型（我们以qwen3为例），进入详情页后根据需求选择参数规模，然后在cmd中执行对应命令，就可以运行大模型了：

```cmd
ollama run qwen3:0.6b
```

（3）接着就可以跟部署的大模型进行对话，如果想退出聊天则输入`/bye`即可

（4）Ollama平台也开放了API，支持以发送HTTP请求的方式来调用本地部署的大模型。本机Ollama默认占用的端口号为11434，发送请求的url为`http://localhost:11434/api/chat`，请求方式必须为POST，请求体必须是JSON格式，样例如下：

```json
{
    "model": "qwen3:0.6b",
    "messages": [
        {
            "role": "user",
            "content": "你是谁？"
        }
    ]
}
```

### 1.2 使用云平台大模型

国内有不少提供大模型服务的云平台：

| **云平台**        | **公司** | **地址**                                                     |
| ----------------- | -------- | ------------------------------------------------------------ |
| 阿里百炼          | 阿里巴巴 | [https://bailian.console.aliyun.com](https://bailian.console.aliyun.com/) |
| 腾讯TI平台        | 腾讯     | https://cloud.tencent.com/product/ti                         |
| 千帆平台          | 百度     | https://console.bce.baidu.com/qianfan/overview               |
| SiliconCloud      | 硅基流动 | https://siliconflow.cn/zh-cn/siliconcloud                    |
| 火山方舟-火山引擎 | 字节跳动 | https://www.volcengine.com/product/ark                       |

这些开放平台并不是免费，而是按照调用时消耗的token来付费。

> 说明：在大语言模型中，**token**是大模型处理文本的基本单位，可以理解为模型"看得懂"的最小文本片段，用户输入的内容都需要通过分词器转换成token，才能让大模型更好的处理。不同的分词器将同一文本转化成token的个数不完全一致，但对于目前大部分分词器而言，4个英文字符约等于1个token，1个中文字符约等于1~2个token。

我们以阿里云百炼平台为例，需要做如下步骤：

（1）登录阿里云官网 https://aliyun.com

（2）开通大模型服务平台百炼服务

![1748054174911](images/1748054174911.png)

（3）点击`免费体验->模型广场->API-Key`，然后创建API-Key

![image-20250705174444327](images/image-20250705174444327.png)

（4）在模型广场中选择自己想要的大模型，点击API参考，查看使用方法。我们以通义千问-Plus为例，发送POST请求即可进行调用

![image-20250705180015560](images/image-20250705180015560.png)

## 2. Open AI接口规范

目前大多数大模型都遵循**OpenAI的接口规范**，是基于Http协议的接口。因此请求参数、返回值信息都是类似的，可能会有一些小的差别，具体需要查看大模型的官方API文档。

- 请求方式：POST（我们需要传递JSON格式的请求体数据）
- 请求路径：与各个平台相关
- 安全校验：开放平台都需要提供API-Key来校验权限

下面我们将重点介绍核心的请求体数据和响应数据。

### 2.1 请求数据

下面是一份请求数据的示例：

```json
{
    "model": "qwen-plus",
    "messages": [
        {
            "role": "system",
            "content": "你是小吴的助手小艾同学，请在每次回答时都先说一句'你好，我是小艾！'"
        },
        {
            "role": "user", 
            "content": "西北大学是211吗？"  # 第一个问题
        },
        {
            "role": "assistant",
            "content": "你好，我是小艾！  \n西北大学是211工程高校。它位于中国陕西省西安市，是一所历史悠久、学科门类齐全的综合性大学。其在文、史、哲、经、管等多个领域具有较强的学科优势。  \n\n如果您有其他问题，欢迎继续提问！"  # 第一个问题的回复
        },
        {
            "role": "user", 
            "content": "是985吗？"  # 第二个问题
        }
    ],
    "stream": true, 
    "enable_search": true
}
```

#### model

必选参数，`string`，用于指定大模型的名称。

#### messages

必选参数，`array`，发送给大模型的消息。其中content是消息内容，role是消息类型，主要有以下三种：

- user：用户发送给模型的消息（必选）。
- system：模型的目标或角色（可选，如果设置system消息则必须将其放在messages列表的第一位）。用于给大模型设定角色和任务背景，然后大模型就可以用该角色的口吻跟用户对话了。
- assistant：模型对用户消息的回复（可选）。大模型是没有记忆能力的（用户与大模型的每次对话都是独立的），所以如果希望大模型能根据以往的聊天信息而进行推断，就需要将之前用户的问题和大模型的回复也一并发送给大模型。

#### stream

可选参数，`boolean`，默认为false

- true：流式返回响应结果，即大模型每生成一部分内容就立即返回一个片段
- false：一次性返回响应结果，即大模型生成完所有内容后一次性返回结果

#### enable_search

可选参数，`boolean`，默认为false。模型在生成文本时是否使用互联网搜索结果进行参考。

> 说明：由于大模型训练完毕后，它的知识库就不再更新了，比如大模型是2023年10月训练完毕的，那么2023年10月以后新产生的数据，大模型就无法感知了。如果要让大模型可以根据最新的数据回答问题，其中有一种解决方案就是开启联网搜索，大模型就可以根据联网搜索的结果生成最终的答案。

#### temperature

可选参数，`float`，采样温度，用于调整模型生成文本时的随机性和多样性，通常取值范围是`[0,1)`，部分模型支持更高的值。温度越高，生成的文本更具有多样性和创造性；温度越低，生成的文本更具有确定性和一致性。

### 2.2 响应数据

下面是一份响应数据的示例：

```json
{
    "choices": [
        {
            "message": {
                "role": "assistant",
                "content": "你好，我是小艾！  \n西北大学不是985工程高校。它虽然是211工程高校，但并未列入国家“985工程”建设行列。不过，作为一所历史悠久、学科实力雄厚的综合性大学，西北大学在人文社科等领域具有很高的声誉和影响力。\n\n如果你还有其他问题，欢迎继续提问哦！"
            },
            "finish_reason": "stop",
            "index": 0,
            "logprobs": null
        }
    ],
    "object": "chat.completion",
    "usage": {
        "prompt_tokens": 128,
        "completion_tokens": 72,
        "total_tokens": 200,
        "prompt_tokens_details": {
            "cached_tokens": 0
        }
    },
    "created": 1751717507,
    "system_fingerprint": null,
    "model": "qwen-plus",
    "id": "chatcmpl-5c2783df-152f-9154-8893-32e448295dcf"
}
```

比较重要的参数有：

- `choices`：模型生成的内容数组，可以包含一条或多条内容
  1. `message`：本次调用模型输出的消息
  2. `finish_reason`：自然结束(stop)，生成内容过长(length)
  3. `index`：当前内容在choices数组中的索引
- `usage`：本次对话过程中使用的token统计
  1. `prompt_tokens`：用户的输入转换成token的个数
  2. `completion_tokens`：模型生成的回复转换成token的个数
  3. `total_tokens`：用户输入和模型生成的总token个数
- `created`：本次会话被创建时的时间戳
- `model`：本次会话使用的模型名称
- `id`：本次调用的唯一标识符



# 第03章_LangChain4j

随着人工智能技术的迅猛发展，越来越多的开发者开始将目光投向AI应用的开发。目前市场上大多数AI框架如LangChain、PyTorch等主要支持Python。使用Java调用大模型的工具库主流有两种：LangChain4j和Spring AI。其中，LangChain4j其实就是LangChain For Java，该框架的目标是简化将LLM集成到Java应用程序中的过程，官方文档为 https://docs.langchain4j.dev/

## 1. 快速入门

创建一个Maven工程后，引入以下依赖：

```xml
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai</artifactId>
    <version>1.0.1</version>
</dependency>
```

构建聊天对象OpenAiChatModel并与大模型进行交互：

```java
public class Main {
    private static final String API_KEY = "你的API-Key";

    // 1. 构建聊天对象OpenAiChatModel
    private static OpenAiChatModel model = OpenAiChatModel.builder()
            .baseUrl("https://dashscope.aliyuncs.com/compatible-mode/v1")  // url参考百炼平台API文档
            .apiKey(API_KEY)
            .modelName("qwen-plus")  // 模型名称
            .build();

    public static void main(String[] args) {
        // 2. 调用chat()方法与大模型进行交互
        String response = model.chat("你是谁？");
        System.out.println(response);
    }
}
```

## 2. SpringBoot整合LangChain4j

### 2.1 基本使用

（1）创建SpringBoot项目后，引入以下依赖：

```xml
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
```

> 说明：LangChain4j提供了Low Level和High Level这两个层次的抽象：
>
> - Low Level：通过**langchain4j-open-ai-spring-boot-starter**依赖引入，提供了低层次的组件，如ChatModel、UserMessage、AiMessage、EmbeddingStore、Embedding等
> - High Level：通过**langchain4j-spring-boot-starter**依赖引入，提供了高层次的组件，如AI Services
>
> 将来我们做大模型应用开发时，这两个依赖都需要引入。

（2）配置文件：

```yaml
langchain4j:
  open-ai:
    chat-model:
      base-url: https://dashscope.aliyuncs.com/compatible-mode/v1
      api-key: 你的API-Key
      model-name: qwen-plus
      log-requests: true   # 打印请求日志
      log-responses: true  # 打印响应日志
```

（3）自动注入OpenAiChatModel后调用大模型：

```java
@RestController
public class ChatController {
    @Autowired
    private OpenAiChatModel model;

    @GetMapping("/chat")
    public String chat(@RequestParam("message") String message) {
        return model.chat(message);
    }
}
```

### 2.2 AiServices工具类

我们之前通过OpenAiChatModel的chat()方法来调用大模型，但这种方式难以完成一些高阶功能，如会话记忆、RAG知识库、Tools工具等。所以LangChain4j为我们提供了AiServices工具类，封装了许多功能操作，帮助我们便捷地调用大模型。

（1）除了langchain4j-open-ai-spring-boot-starter依赖外，我们还需引入以下依赖：

```xml
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
```

（2）配置文件与之前相同

（3）自定义服务接口

```java
public interface ChatService {
    String chat(String message);
}
```

（4）使用AiServices工具类创建服务接口的动态代理对象

```java
@Configuration
public class MyConfig {
    @Autowired
    private OpenAiChatModel model;

    @Bean
    public ChatService chatService() {
        return AiServices.builder(ChatService.class).chatModel(model).build();
    }
}
```

（5）Controller中可以直接调用服务接口的方法

```java
@RestController
public class ChatController {
    @Autowired
    private ChatService chatService;

    @GetMapping("/chat")
    public String chat(@RequestParam("message") String message) {
        return chatService.chat(message);
    }
}
```

### 2.3 AiService声明式使用

为了简化AiServices工具类的使用，LangChain4j提供了声明式使用方法，想为哪个service接口创建代理对象，只需要在该接口上添加@AiService注解并指定要使用的模型，将来LangChain4j扫描到该注解后会自动创建该接口的代理对象并注入到IoC容器中。

由此，我们只需编写如下的service接口，而无需再编写上述MyConfig配置类。

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel"
)
public interface ChatService {
    String chat(String message);
}
```

> 注意：
>
> - wiringMode默认为AUTOMATIC（自动装配），也就是会自动去装配IoC容器中已有的模型，例如框架自带的`openAiChatModel`，所以事实上上述`@AiService`的这两个属性都可以无需指定。
> - 我们上面将wiringMode设置为EXPLICIT（手动装配），这时候我们就必须手动指定要装配的模型，chatModel就用于指定对话时需要使用的模型对象在IoC容器中的名称。

说明：我们可以将资料目录下的index.html放在项目类路径的static目录下，后续我们将基于这一前端页面做案例演示。

## 3. 流式输出

流式输出是一种分批次实时传输LLM生成结果给客户端的技术，尤其适用于LLM响应较慢的场景（如生成长文本或复杂推理结果）。我们之前代码演示的都是阻塞式调用，如果想进行流式调用，则需要使用webflux框架。

（1）创建一个新项目，引入依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-webflux</artifactId>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-reactor</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
```

（2）配置文件（需要配置流式模型streamingChatModel）：

```yaml
langchain4j:
  open-ai:
    streaming-chat-model:
      base-url: https://dashscope.aliyuncs.com/compatible-mode/v1
      api-key: 你的API-Key
      model-name: qwen-plus
      log-requests: true   # 打印请求日志
      log-responses: true  # 打印响应日志
```

（3）Service接口（通过`@AiService`注解的streamingChatModel指定流式模型）：

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        streamingChatModel = "openAiStreamingChatModel"
)
public interface ChatService {
    Flux<String> chat(String message);
}
```

（4）Controller

```java
@RestController
public class ChatController {
    @Autowired
    private ChatService chatService;

    // produces属性用于解决乱码问题
    @GetMapping(value = "/chat", produces = "text/html;charset=utf-8")
    public Flux<String> chat(@RequestParam("message") String message) {
        return chatService.chat(message);
    }
}
```

> 说明：我们可以将资料目录下的index.html放在项目类路径的static目录下，基于这一前端页面可以更直观地看到流式调用的效果。

## 4. 提示词工程

### 4.1 简介

提示词工程（Prompt Engineering）是指通过结构化文本等方式来设计和优化提示词，以引导大语言模型输出期望的结果。好的提示词一般有以下要求：

1. 清晰明确的指令
2. 使用分隔符标记输入
3. 按步骤拆解复杂任务
4. 提供输入输出示例
5. 明确要求输出格式
6. 给模型设定一个角色

Prompt一般通过多角色消息的方式来设计，也就是将消息分为不同角色（user、system、assistant等），设置功能边界，增强交互的复杂性和上下文感知能力。

LangChain4j通过枚举类ChatMessageType定义了五种类型的消息：

- `SystemMessage`：系统消息，用于设定模型的目标或角色，通常会用它来设定LLM在这次对话中的角色、应该如何表现、以什么风格回答等指令；
- `UserMessage`：用户消息；
- `AiMessage`：由AI生成的消息，通常是对用户消息的回复；
- `ToolExecutionResultMessage`：Tool执行的结果，每个ToolExecutionRequest对应一个ToolExecutionResultMessage；
- `CustomMessage`：自定义消息，这种消息类型只能由支持它的ChatModel使用

### 4.2 系统消息的使用

我们之前提到，在发送HTTP请求时，可以通过设置system类型的消息，来给大模型设定一个角色。而在代码中，我们可以使用LangChain4j为我们提供的消息注解`@SystemMessage`来设置system类型的消息。

**方式一**：在value属性中直接指定系统消息内容

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel"
)
public interface ChatService {
    @SystemMessage("你是小吴的助手小艾同学，请在每次回答时都先说一句'你好，我是小艾！'")
    String chat(String message);
}
```

**方式二**：如果系统消息内容很多，则可以通过fromResource属性指定一个外部文件

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel"
)
public interface ChatService {
    @SystemMessage(fromResource = "system.txt")
    String chat(String message);
}
```

> 说明：我们可以将资料目录下的system.txt文件放在项目的类路径下。

### 4.3 提示词模板的使用

我们也可以使用**提示词模板**来拼接用户提问的内容，精确控制输入和期望的输出格式，确保问题被LLM正确地理解和回答。

#### 方式一

Service接口：通过`@UserMessage`来设置user类型的消息，结合`@V`注解以及占位符`{{ }}`来拼接用户提问的内容

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel"
)
public interface DocumentGenerateService {
    String PROMPT_TEMPLATE = """
            ## 角色设定
            你是一个智能的文档生成助手，能帮助用户快速生成所需的文档。
            
            ## 任务目标
            {{task}}
            
            ## 任务要求
            - 生成的文档要包含四部分内容：背景、目标、实现方案、总结
            - 语言要专业化
            - 生成的文档必须是markdown格式
            """;

    @UserMessage(PROMPT_TEMPLATE)
    String documentGenerate(@V("task") String message);
}
```

测试：

```java
@SpringBootTest
public class AiBootDemoApplicationTests {
    @Autowired
    private DocumentGenerateService documentGenerateService;
    
    @Test
    public void test() {
        String message = "生成一份关于搭建AI智能体的技术方案，2000字左右";
        String result = documentGenerateService.documentGenerate(message);
        System.out.println(result);
    }
}
```

#### 方式二

如果要拼接的参数很多，我们也可以使用`@StructuredPrompt`标注一个实体类作为提示词模板。

提示词模板实体类：

```java
@Data
@StructuredPrompt(
        """
        ## 角色设定
        你是一个智能的文档生成助手，能帮助用户快速生成所需的文档。
                    
        ## 任务目标
        {{task}}
                    
        ## 任务要求
        - 生成的文档要包含四部分内容：背景、目标、实现方案、总结
        - 语言要专业化
        - 生成的文档必须是markdown格式
        - 字数在{{length}}左右
        """
)
public class DocumentGeneratePrompt {
    private String task;
    private Integer length;
}
```

Service接口：

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel"
)
public interface DocumentGenerateService {
    String documentGenerate(DocumentGeneratePrompt prompt);
}
```

测试：

```java
@SpringBootTest
public class AiBootDemoApplicationTests {
    @Autowired
    private DocumentGenerateService documentGenerateService;

    @Test
    public void test() {
        DocumentGeneratePrompt prompt = new DocumentGeneratePrompt();
        prompt.setTask("生成一份关于搭建AI智能体的技术方案");
        prompt.setLength(2000);
        String result = documentGenerateService.documentGenerate(prompt);
        System.out.println(result);
    }
}
```

## 5. 会话记忆

### 5.1 会话记忆原理

大模型是不具备记忆能力的，每次对话都是独立的。所以想实现会话记忆，就需要将之前聊天的所有内容和新的问题一起发送给大模型。

LangChain4j提供了一个接口ChatMemory，是用于实现会话记忆的标准接口：

```java
public interface ChatMemory {
    /**
     * 用于唯一标识本次会话的ID
     */
    Object id();

    /**
     * 向指定ID的会话中保存一条消息
     */
    void add(ChatMessage message);

    /**
     * 获取指定ID的会话中保存的所有消息
     */
    List<ChatMessage> messages();

    /**
     * 清空指定ID会话中的所有消息
     */
    void clear();
}
```

> 说明：**必须使用唯一ID来标识每一次会话**，因为用户点击新建会话时就应该使用新的会话记忆，而不是沿用旧的会话记忆。

**整体流程**：当用户发送问题时，LangChain4j会将该消息存储到指定ID的ChatMemory中，然后获取该ID保存的所有消息并发送给大模型；大模型生成文本后会将响应消息也存储到指定ID的ChatMemory中，然后响应用户。

ChatMemory有以下两个实现类：

- MessageWindowChatMemory：采用滑动窗口的方式，保留最新的N条消息，并淘汰较旧的消息。
- TokenWindowChatMemory：采用滑动窗口的方式，保留最新的N个Token，并淘汰较旧的消息。需要结合TokenCountEstimator来计算每条ChatMessage中的Token数量。

我们一般使用MessageWindowChatMemory来实现会话记忆即可：

```java
public class MessageWindowChatMemory implements ChatMemory {
    private final Object id;
    private final ChatMemoryStore store;  // 存储消息的容器

    public Object id() {
        return this.id;
    }

    public void add(ChatMessage message) {
        List<ChatMessage> messages = this.messages();
        if (message instanceof SystemMessage) {
            Optional<SystemMessage> systemMessage = findSystemMessage(messages);
            if (systemMessage.isPresent()) {
                if (((SystemMessage)systemMessage.get()).equals(message)) {
                    return;
                }
                messages.remove(systemMessage.get());
            }
        }
        messages.add(message);
        ensureCapacity(messages, this.maxMessages);
        this.store.updateMessages(this.id, messages);
    }

    public List<ChatMessage> messages() {
        List<ChatMessage> messages = new LinkedList(this.store.getMessages(this.id));
        ensureCapacity(messages, this.maxMessages);
        return messages;
    }

    public void clear() {
        this.store.deleteMessages(this.id);
    }
    
    // ......
}
```

其中ChatMemoryStore才是真正存储消息的容器，所以我们需要实现ChatMemoryStore接口来将消息存储到持久化介质中（例如Redis）。

### 5.2 会话记忆的实现流程

#### 1、实现ChatMemoryStore存储消息

我们首先要在项目中进行Redis的相关配置：

引入依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

添加配置：

```yaml
spring:
  data:
    redis:
      password: abc666
      host: 192.168.231.203
      port: 6379
```

然后自定义类实现ChatMemoryStore接口：

```java
@Component
public class RedisChatMemoryStore implements ChatMemoryStore {
    @Autowired
    private StringRedisTemplate redisTemplate;

    /**
     * 向指定ID的会话中保存一条消息
     */
    @Override
    public void updateMessages(Object memoryId, List<ChatMessage> messages) {
        String json = ChatMessageSerializer.messagesToJson(messages);
        redisTemplate.opsForValue().set(memoryId.toString(), json, Duration.ofDays(1));
    }

    /**
     * 获取指定ID的会话中保存的所有消息
     */
    @Override
    public List<ChatMessage> getMessages(Object memoryId) {
        String json = redisTemplate.opsForValue().get(memoryId.toString());
        return ChatMessageDeserializer.messagesFromJson(json);
    }

    /**
     * 清空指定ID会话中的所有消息
     */
    @Override
    public void deleteMessages(Object memoryId) {
        redisTemplate.delete(memoryId.toString());
    }
}
```

#### 2、配置会话记忆对象ChatMemory

我们使用ChatMemory的一个实现类MessageWindowChatMemory，进行配置：

```java
@Configuration
public class CommonConfig {
    @Autowired
    private ChatMemoryStore redisChatMemoryStore;

    @Bean
    public ChatMemoryProvider chatMemoryProvider() {
        return new ChatMemoryProvider() {
            @Override
            public ChatMemory get(Object memoryId) {
                return MessageWindowChatMemory.builder()
                        .id(memoryId)
                        .maxMessages(100)  // 该会话最大可以存储的消息数量
                        .chatMemoryStore(redisChatMemoryStore)  // 配置ChatMemoryStore
                        .build();
            }
        };
    }
}
```

#### 3、service接口

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel",
        chatMemoryProvider = "chatMemoryProvider"  // 配置会话记忆对象提供者
)
public interface ChatService {
    // 添加参数memoryId，并通过LangChain4j提供的注解区分ID和消息内容
    @SystemMessage(fromResource = "system.txt")
    String chat(@MemoryId String memoryId, @UserMessage String message);
}
```

#### 4、controller

```java
@RestController
public class ChatController {
    @Autowired
    private ChatService chatService;

    @GetMapping("/chat")
    public String chat(
            @RequestParam("memoryId") String memoryId,
            @RequestParam("message") String message) {
        return chatService.chat(memoryId, message);
    }
}
```

> 说明：在我们提供的前端页面中，实际上已经传递了参数memoryId

## 6. RAG

### 6.1 RAG简介

RAG全称为Retrieval Augmented Generation（**检索增强生成**），是一种结合信息检索与文本生成的技术，旨在提升大语言模型在回答专业问题时的准确性和可靠性。简单理解就是通过检索外部知识库的方式增强大模型的生成能力，从而降低产生幻觉的概率。

> 说明：幻觉是指LLM生成的内容看似合理且自信，但实际上是不真实、不准确或完全虚构的信息。

**为什么需要RAG**？因为通用大模型只基于其训练数据生成响应，所以存在两大问题：一是无法获取专业领域的数据，二是无法得知训练之后的最新数据。

- 场景一：LLM的训练依赖于网络上海量公开的静态数据，而某些**特定领域**（如企业内部资料、专有技术文档等）的数据通常不会作为公开的训练数据，导致模型在面对这些领域的查询时，可能因缺乏足够的信息而产生幻觉。为此，可以采用RAG技术，引入向量数据库作为外部知识源，将模型缺失的知识以结构化的形式提供。
- 场景二：随着LLM规模扩大，训练成本与周期相应增加，因此包含**最新信息的数据难以融入模型训练过程**，导致LLM在应对诸如"请推荐当前热门影片"等时间敏感性问题时表现不佳。为此，可以采用联网搜索功能，这也是一种广义的RAG。

**普通大模型的整体流程**：

![image-20250706163451582](images/image-20250706163451582.png)

**通过RAG外挂知识库后的整体流程**：

![image-20250706163621449](images/image-20250706163621449.png)

我们需要关注的**核心问题**有两个：

1. 知识库应该怎么搭建
2. 如何从知识库中检索出用户问题相关的知识片段

而对于其他流程，LangChain4j都能帮助我们自动完成。

### 6.2 RAG基本原理

#### 存储数据

知识库通常会使用一种特殊的数据库（向量数据库）。目前市面上常见的向量数据库很多，比如Milvus、Chroma、Pinecone、RediSearch等。存储数据的**基本原理**如下：

![image-20250706174442300](images/image-20250706174442300.png)

首先我们需要把最新的数据或者专业的数据存储到文档中，接下来借助**文本分割器**把一个大的文档分割成一个一个小的文本片段，然后这些小的文本片段需要借助于**向量模型**转换成高维向量（向量模型是一种专门的大模型，擅长文本向量化），接下来把每个向量和其对应的文本片段一起存储到向量数据库中。

> RAG知识库中使用的向量，一般是几百到几千个维度

![image-20250706165658692](images/image-20250706165658692.png)

#### 检索与用户问题相关的数据片段

在向量数据库中，两个向量的接近程度通常采用**余弦相似度**来衡量，余弦相似度就是两个向量夹角的余弦值，所以余弦相似度越大（越接近1），两个向量就越接近。从向量数据库中检索与用户问题相关的数据片段的**基本原理**如下：

![image-20250706191517871](images/image-20250706191517871.png)

用户提交的消息同样会使用**向量模型**转换为高维向量，接下来拿着该向量和向量数据库中已经存在的向量进行比对，计算它们之间的余弦相似度，把满足要求的向量筛选出来（例如，余弦相似度大于0.5）得到其对应的文本片段，最后结合用户提交的消息和从向量数据库中检索到的文本片段，组织数据发送给大模型。

![image-20250706191931417](images/image-20250706191931417.png)

### 6.3 搭建知识库

我们想通过RAG的方式增强大模型的生成能力，从而让我们能够查询出最新的2024年的大学录取分数线。所以我们首先需要搭建知识库，将相关数据转换为多维向量保存到知识库中。

#### 1、向量数据库RediSearch

我们选用RediSearch作为知识库，RediSearch是Redis扩展的一个功能，Docker安装命令如下：

```shell
docker run --name redis-vector -d -p 6380:6379 redislabs/redisearch
```

#### 2、引入依赖

额外引入以下依赖：

```xml
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-easy-rag</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-community-redis-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
```

#### 3、配置文件

**配置向量模型**：

向量模型的作用是将分割后的文本片段向量化或者把用户消息向量化。LangChain4j中提供了EmbeddingModel接口用于定义有关向量模型的方法。事实上，LangChain4j默认提供了一个内存版本的向量模型实现方案，但是这种内置的向量模型功能没有那么强大，所以我们选择使用阿里云百炼平台提供的专业的向量模型text-embedding-v3，因此我们就需要进行配置。

在配置文件中新增以下内容：

```yaml
langchain4j:
  open-ai:
    # 配置向量模型
    embedding-model:
      base-url: https://dashscope.aliyuncs.com/compatible-mode/v1
      api-key: 你的API-Key
      model-name: text-embedding-v3
      log-requests: true
      log-responses: true
      max-segments-per-batch: 10  # 向量模型text-embedding-v3规定每次发送请求的数据不超过10行
```

> 说明：当我们进行上述配置后，LangChain4j会自动根据我们的配置往IoC容器中注册一个EmbeddingModel对象供我们使用。

**配置向量数据库连接信息**：在配置文件中新增以下内容：

```yaml
langchain4j:
  community:
    # 配置向量数据库连接信息
    redis:
      host: 192.168.231.203
      port: 6380
```

> 说明：当我们进行上述配置后，LangChain4j会自动根据我们的配置往IoC容器中注册一个RedisEmbeddingStore对象，这个对象实现了EmbeddingStore接口，封装了操作RediSearch的API。

#### 4、完成知识库的搭建

我们首先将资料目录下的content文件夹复制到项目的类路径下，这是我们的知识数据文档。

然后定义一个临时的配置类用于在SpringBoot初始化时存储数据到知识库：

```java
@Configuration
public class TempConfig {
    @Autowired
    private EmbeddingModel embeddingModel;
    @Autowired
    private RedisEmbeddingStore redisEmbeddingStore;

    @PostConstruct
    public void buildKnowledgeBase() {
        // 1. 使用文档加载器将文档加载进内存
        List<Document> documents = ClassPathDocumentLoader.loadDocuments("content");

        // 2. 构建EmbeddingStoreIngestor对象，它的功能是进行文本数据的切割、向量化、存储
        EmbeddingStoreIngestor ingestor = EmbeddingStoreIngestor.builder()
                .embeddingModel(embeddingModel)  // 指定向量模型
                .embeddingStore(redisEmbeddingStore)  // 指定向量数据库操作对象
                .build();

        // 3. 对文档数据进行切割、向量化，然后存储到知识库
        ingestor.ingest(documents);
    }
}
```

启动程序后我们就会发现，RediSearch知识库已经搭建完成。注意，知识库搭建完成后需要把TempConfig这个临时配置类注释掉，否则每次启动程序都会重新搭建一次知识库。

> 说明：EmbeddingStoreIngestor类封装了很多细节，它的核心功能是使用文档分割器来对文本数据进行**切割**、然后使用向量模型完成**向量化**、最后将每个向量和其对应的文本片段一起**存储**到向量数据库中。

### 6.4 检索知识库

#### 1、配置ContentRetriever

我们在CommonConfig中配置ContentRetriever：

```java
    @Autowired
    private EmbeddingModel embeddingModel;
    @Autowired
    private RedisEmbeddingStore redisEmbeddingStore;

    @Bean
    public ContentRetriever contentRetriever() {
        return EmbeddingStoreContentRetriever.builder()
                .embeddingModel(embeddingModel)  // 指定向量模型
                .embeddingStore(redisEmbeddingStore)  // 指定向量数据库操作对象
                .minScore(0.5)  // 设置最小的余弦相似度（只有高于此值的片段才会被检索出来）
                .maxResults(3)  // 设置检索出来的最大片段数量
                .build();
    }
```

> 说明：EmbeddingStoreContentRetriever是LangChain4j提供的向量数据库检索对象。

#### 2、service接口指定检索器

通过`@AiService`注解的contentRetriever属性指定向量数据库检索对象：

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel",
        chatMemoryProvider = "chatMemoryProvider",  // 配置会话记忆对象提供者
        contentRetriever = "contentRetriever"  // 配置向量数据库检索对象
)
public interface ChatService {
    @SystemMessage(fromResource = "system.txt")
    String chat(@MemoryId String memoryId, @UserMessage String message);
}
```

**测试**：启动程序后，询问AI志愿填报顾问："西北大学2024年录取分数是多少"，发现已经可以正确地根据知识库的内容来回答了。可以在IDEA的控制台查看日志，会发现发送给大模型的用户消息中，格式是这样的：

![image-20250712224212871](images/image-20250712224212871.png)

### 6.5 RAG核心组件总结

![image-20250713094200314](images/image-20250713094200314.png)

知识库的存储流程如上图所示，其中涉及到了5个核心组件：

#### 文档加载器

文档加载器的作用是把磁盘或者网络中的文档数据加载进内存。LangChain4j给我们提供的常见文档加载器有：

- ClassPathDocumentLoader：相对于类路径加载
- FileSystemDocumentLoader：根据本地磁盘绝对路径加载
- UrlDocumentLoader：根据url路径加载

#### 文档解析器

文档解析器（DocumentParser）的作用是解析文档中的内容，把原本的非纯文本数据转化成纯文本，最后在内存中生成一个一个的Document对象用于记录文档的内容。在LangChain4j中提供了几个常用的文档解析器：

- ApacheTikaDocumentParser（默认）：几乎可以解析所有格式的文件
- TextDocumentParser：解析纯文本格式的文件
- ApachePdfBoxDocumentParser：解析pdf格式文件
- ApachePoiDocumentParser：解析微软的office文件，例如DOC、PPT、XLS

#### 文档分割器

文档分割器（DocumentSplitter）主要用于把一个大的文档切割成一个一个的文本片段。由于每个Document对象中记录的是对应文档中的全部内容，如果我们直接把整个文档的内容一次性向量化存储到向量数据库中，不利于检索，所以这些文档对象，需要使用文档分割器分割成一个一个的文本片段，而每一个文本片段只是记录整个文档中的一小部分内容，这样将来根据用户问题检索相关片段的时候就会更精准。

LangChain4j提供了多种文档分割器：

- DocumentSplitters.recursive()：（默认）递归分割器，优先按照段落分割、再按照行分割、再按照句子分割、再按照词分割，直到达到每个文本片段设置的最大字符数
- DocuemntByParagraphSplitter：只按照段落分割文本
- DocumentByLineSplitter：只按照行分割文本
- DocumentBySentenceSplitter：只按照句子分割文本
- DocumentByWordSplitter：只按照词分割文本
- DocumentByCharacterSplitter：按照固定数量的字符分割文本
- DocumentByRegexSplitter：按照正则表达式分割文本

如下是段落文本分割器的例子，假设我们设置了每个文本片段的最大字符数是300，那么将文档按照段落进行分割后，发现第一个文本片段中只能放下第1段和第2段（再加上第3段则会超过300字符），于是第3段会放到下一个文本片段中。将来我们进行向量化时，实际上是对**每个文本片段**进行向量化的。

![image-20250713095911016](images/image-20250713095911016.png)

> 说明：如果我们采用默认的递归分割器，那么在上述的例子中，放入两个段落后，还会尝试能否放入行、句子、词，直到该文本片段达到300个字符。

LangChain4j默认使用的递归分割器，其单个文本片段的最大字符数就是300，如果我们想自定义，则可以使用以下API：

```java
DocumentSplitter documentSplitter = DocumentSplitters.recursive(maxSegmentSizeInChars, maxOverlapSizeInChars);
```

其中，maxSegmentSizeInChars表示每个文本片段容纳的最大字符数，而maxOverlapSizeInChars表示两个文本片段之间重叠的字符数。设置重叠字符数的作用如下：

![image-20250713101932527](images/image-20250713101932527.png)

假如有一篇以"高考"为题目的文档需要存储到向量数据库中，使用文档分割器后得到两个文本片段，其中第一个文本片段里提到"高考"，而第二个文本片段中完全没有出现"高考"相关的字眼，那到时候我们检索"高考"相关的内容时就无法将第二个文本片段检索出来，但实质上按照语义它是应该被检索出来的。我们的解决办法就是让两个文本片段存储的内容有重叠的部分，即上一个文本片段的末尾与下一个文本片段的开头重复，这样就可以保持语义的连贯性了。比如将"高考不是重点，而是起点..."这句话存储到第二个文本片段的开头，就能解决上述问题，所以maxOverlapSizeInChars就是用于指定重叠部分字符的数量。

我们在构建EmbeddingStoreIngestor时，可以指定我们自定义的文档分割器对象：

```java
@Configuration
public class TempConfig {
    @Autowired
    private EmbeddingModel embeddingModel;
    @Autowired
    private RedisEmbeddingStore redisEmbeddingStore;

    @PostConstruct
    public void buildKnowledgeBase() {
        // 1. 使用文档加载器将文档加载进内存
        List<Document> documents = ClassPathDocumentLoader.loadDocuments("content");

        // 2. 构建EmbeddingStoreIngestor对象，它的功能是进行文本数据的切割、向量化、存储
        EmbeddingStoreIngestor ingestor = EmbeddingStoreIngestor.builder()
                .embeddingModel(embeddingModel)  // 指定向量模型
                .embeddingStore(redisEmbeddingStore)  // 指定向量数据库操作对象
                .documentSplitter(DocumentSplitters.recursive(500, 100))  // 指定文档分割器对象
                .build();

        // 3. 对文档数据进行切割、向量化，然后存储到知识库
        ingestor.ingest(documents);
    }
}
```

#### 向量模型

向量模型（EmbeddingModel）的作用是将一个个文本片段转换为一个个向量。LangChain4j中使用Embedding对象来记录这一个个向量。

#### 向量数据库操作对象

向量数据库操作对象（EmbeddingStore）封装了操作向量数据库的API，无论是存储还是检索都需要借助于它来完成。

## 7. Tools

### 7.1 业务需求案例

在我们的AI志愿填报顾问中，已经设置了如下系统消息，会在每次回答完用户的问题后，都附上一句话：志愿填报需要考虑的因素有很多，如果要得到专业的志愿填报指导，建议您预约一个一对一的指导服务，是否需要预约? 

我们想实现以下功能：当用户表达出需要预约的意愿并提交姓名、性别、电话等信息后，就往数据库中添加一条信息，记录预约详情。为此，我们首先搭建数据库环境。

执行SQL脚本：

```sql
create database if not exists volunteer;
use volunteer;
create table if not exists reservation
(
    id                 bigint primary key auto_increment not null comment '主键ID',
    name               varchar(50) not null comment '考生姓名',
    gender             varchar(2)  not null comment '考生性别',
    phone              varchar(20) not null comment '考生手机号',
    communication_time datetime    not null comment '沟通时间',
    province           varchar(32) not null comment '考生所处的省份',
    estimated_score    int         not null comment '考生预估分数'
)
```

引入依赖：

```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
</dependency>
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-spring-boot3-starter</artifactId>
    <version>3.5.8</version>
</dependency>
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <scope>runtime</scope>
</dependency>
```

添加配置：

```yaml
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://192.168.231.203:3306/volunteer
    username: root
    password: abc666
```

实体类：

```java
@TableName("reservation")
@Data
public class Reservation {
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    private String name;
    private String gender;
    private String phone;
    private LocalDateTime communicationTime;
    private String province;
    private Integer estimatedScore;
}
```

Mapper：

```java
@Mapper
public interface ReservationMapper extends BaseMapper<Reservation> {
}
```

Service：

```java
public interface ReservationService {
    /**
     * 添加预约信息记录
     */
    void insert(Reservation reservation);

    /**
     * 根据手机号查询预约信息记录
     */
    Reservation queryByPhone(String phone);
}
```

```java
@Service
public class ReservationServiceImpl implements ReservationService {
    @Autowired
    private ReservationMapper reservationMapper;

    @Override
    public void insert(Reservation reservation) {
        reservationMapper.insert(reservation);
    }

    @Override
    public Reservation queryByPhone(String phone) {
        return reservationMapper.selectOne(
                new LambdaQueryWrapper<Reservation>().eq(Reservation::getPhone, phone) 
        );
    }
}
```

### 7.2 Tools工具原理

Tools工具，以前也叫做Function Calling。它允许LLM在必要时表达调用Tools的意图，这些Tools通常由开发人员定义（Tools可以是网络搜索、外部API、特定代码片段等）。注意，LLM本身并不能实际调用Tools，而是会在响应中指示应该调用哪个Tools以及如何调用。

如果在我们的程序中添加了Tools功能，那么整个工作流程就会变成以下情形：

![image-20250714214722034](images/image-20250714214722034.png)

当用户把问题发送给AI应用，在AI应用的内部需要组织提交给大模型的数据，而这些数据中需要描述清楚我们的AI应用中有哪些函数能够被大模型调用。每一个函数的描述都包含三个部分：方法名称、方法作用、方法入参。当AI应用把这些数据发送给大模型后，大模型会先根据用户的问题以及上下文拆解任务，从而判断是否需要调用函数，如果有函数需要调用，则把需要调用的函数名称，以及调用时需要使用的参数准备好一并响应给AI应用。AI应用接收到响应后需要执行对应的函数，得到对应的结果，接下来把得到的结果和之前的信息一块组织好再发送给大模型。

这里需要注意的是由于在一次任务的处理过程中可能需要根据顺序调用多个函数，所以当大模型再次接收到AI应用发送的数据后会继续拆解任务，如果发现还需要调用其他的函数，则会重复4.1~4.4这几个步骤，直到无需调用函数，最终把生成的结果响应给AI应用，并由AI应用发送给用户。

### 7.3 Tools的使用方式

LangChain4j提供了`@Tool`注解用于对方法的作用进行描述，还有`@P`注解用于对方法的参数进行描述。将来LangChain4j就能通过反射的方式获取到`@Tool`注解中的作用描述、`@P`注解中的参数描述、以及方法的名称，然后组织数据一并发送给大模型。

```java
@Component
public class ReservationTool {
    @Autowired
    private ReservationService reservationService;

    /**
     * 工具方法：添加预约信息
     */
    @Tool("预约志愿填报服务")
    public void addReservation(
            @P("考生姓名") String name,
            @P("考生性别") String gender,
            @P("考生手机号") String phone,
            @P("预约沟通时间，格式为：yyyy-MM-dd'T'HH:mm") String communicationTime,
            @P("考生所在省份") String province,
            @P("考生预估分数") Integer estimatedScore
    ) {
        Reservation reservation = new Reservation();
        reservation.setName(name);
        reservation.setGender(gender);
        reservation.setPhone(phone);
        reservation.setCommunicationTime(LocalDateTime.parse(communicationTime));
        reservation.setProvince(province);
        reservation.setEstimatedScore(estimatedScore);
        
        reservationService.insert(reservation);
    }

    /**
     * 工具方法：查询预约信息
     */
    @Tool("根据考生手机号查询预约信息")
    public Reservation queryReservation(@P("考生手机号") String phone) {
        return reservationService.queryByPhone(phone);
    }
}
```

然后通过`@AiService`注解的tools属性指定Tools类，这样就给ChatService业务配置好了Tools工具：

```java
@AiService(
        wiringMode = AiServiceWiringMode.EXPLICIT,
        chatModel = "openAiChatModel",
        chatMemoryProvider = "chatMemoryProvider",  // 配置会话记忆对象提供者
        contentRetriever = "contentRetriever",  // 配置向量数据库检索对象
        tools = "reservationTool"  // 指定Tools工具
)
public interface ChatService {
    @SystemMessage(fromResource = "system.txt")
    String chat(@MemoryId String memoryId, @UserMessage String message);
}
```

测试：

![image-20250714221836005](images/image-20250714221836005.png)

## 8. MCP

AI Agent领域有两个重大挑战：

1. Agent与Tools的交互方式，也就是Agent需要调用外部工具和API来执行代码等。**MCP协议正是Agent与Tools交互的标准协议**。
2. Agent与其他Agent的交互方式，也就是Agent需要理解其他Agent的意图来协同完成任务。**A2A协议正是多个Agent之间交互的标准协议**。

### 8.1 MCP简介

MCP（Model Context Protocol，模型上下文协议）是2024年11月底由Anthropic推出的一种开放标准，旨在**为AI模型应用提供统一的标准化方式与外部数据源和工具之间进行通信**。

![image-20250720122444874](images/image-20250720122444874.png)

MCP遵循CS架构（客户端-服务器架构），包含以下五个核心部分：

1. MCP Host（MCP主机）：AI应用程序，是运行MCP的主应用程序，为用户提供与LLM交互的接口，同时集成MCP Client以连接MCP Server；
2. MCP Client（MCP客户端）：集成在MCP Host内部，主要负责接收来自LLM的请求、将请求转发到相应的MCP Server、将MCP Server的结果返回给LLM；
3. MCP Server（MCP服务端）：提供一组特定的工具，负责从本地数据或远程服务中检索信息。注意，与传统的远程API服务器不同，MCP服务端既可以作为本地应用程序在本机运行（stdio模式），也可以部署至远程服务器（SSE模式）；
4. Local Resource（本地资源）：本地计算机中可供MCP Server安全访问的资源，如文件、数据库等
5. Remote Resource（远程资源）：MCP Server可以连接到的远程资源，如通过API提供的数据

![image-20250720123353785](images/image-20250720123353785.png)

假设你正在使用一个AI编程助手来帮助你写代码。这个AI编程助手就是一个MCP Host，它需要访问一些外部资源，比如代码库、文档、调试工具等。MCP Server就像是一个中介，它连接了这些资源和AI编程助手：

1. 当你向AI编程助手提问某个函数的用法时，AI编程助手就会通过MCP Client向MCP Server发送请求；
2. MCP Server接收到请求后，就会去代码库或文档中查找相关信息，找到信息后再将结果返回给AI编程助手；
3. AI编程助手根据返回的信息，生成一段代码或解释并展示给你。

![image-20250720171442377](images/image-20250720171442377.png)

### 8.2 MCP的通信机制

MCP支持两种通信机制（传输方式）：

- stdio（标准输入输出）：主要用在本地服务上，操作你本地的软件和文件。这是MCP**默认**的通信方式。
- SSE（Server-Sent Events）：主要用在远程通信服务上，这个服务需要有在线的API，比如访问谷歌邮件、天气情况等。

![image-20250720125433899](images/image-20250720125433899.png)

> 说明：stdio模式适用于MCP Client和MCP Server在同一台机器上运行的场景，通信速度更快。但stdio的配置比较复杂，需要在本地安装以下两种指令：
>
> - uvx：对于Python编写的服务（MCP Server），需要安装uvx指令。首先需要在本地配置Python环境，然后执行`pip install uv`命令即可。
> - npx：对于TypeScript编写的服务（MCP Server），需要安装npx指令。只需下载安装Node.js即可。

### 8.3 MCP案例实战

> 说明：我们可以访问MCP平台 https://mcp.so/zh 来寻找优秀的MCP Server并使用。

本次我们使用百度地图MCP Server作为演示 https://mcp.so/zh/server/baidu-map/baidu-maps ，可以看到它提供了丰富的Tools工具，并且是一个TypeScript编写的服务（提供了npx的接入方式）：

![image-20250720143310247](images/image-20250720143310247.png)

#### 1、百度地图API-Key申请

（1）访问 https://lbsyun.baidu.com/apiconsole/key 注册账号并认证

（2）点击"创建应用"，其中应用名称可以随意填写，IP白名单填写`0.0.0.0/0`，然后点击提交

（3）这样就完成了API-Key的申请

#### 2、引入依赖

创建一个新的工程，并引入依赖：

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<!-- MCP依赖 -->
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-mcp</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
```

#### 3、配置文件

```yaml
langchain4j:
  open-ai:
    chat-model:
      base-url: https://dashscope.aliyuncs.com/compatible-mode/v1
      api-key: 你的API-Key
      model-name: qwen-plus
      log-requests: true   # 打印请求日志
      log-responses: true  # 打印响应日志
```

#### 4、Service接口

```java
public interface McpService {
    String chat(String message);
}
```

#### 5、MCP核心配置

```java
@Configuration
public class McpConfig {
    private static final String BAIDU_MAP_API_KEY = "你的百度地图API-Key";

    @Autowired
    private OpenAiChatModel model;

    @Bean
    public McpService mcpService() {
        try (
                // 1. 构建MCP Transport（根据百度地图MCP Server提供的npx接入方式）
                StdioMcpTransport transport = new StdioMcpTransport.Builder()
                        .command(List.of("cmd", "/c", "npx", "-y", "@baidumap/mcp-server-baidu-map"))
                        .environment(Map.of("BAIDU_MAP_API_KEY", BAIDU_MAP_API_KEY))
                        .build();
                // 2. 构建MCP Client
                DefaultMcpClient mcpClient = new DefaultMcpClient.Builder()
                        .transport(transport)
                        .build();
                ) {
            // 3. 创建工具集
            McpToolProvider toolProvider = McpToolProvider.builder()
                    .mcpClients(mcpClient)
                    .build();
            // 4. 给Service接口指定工具集
            McpService mcpService = AiServices.builder(McpService.class)
                    .chatModel(model)
                    .toolProvider(toolProvider)
                    .build();
            return mcpService;
        } catch (Exception e) {
            System.out.println("McpService构建异常" + e);
            throw new RuntimeException(e);
        }
    }
}
```

#### 6、测试

```java
@RestController
public class McpController {
    @Autowired
    private McpService mcpService;
    
    @GetMapping("/chat")
    public String chat(@RequestParam("message") String message) {
        return mcpService.chat(message);
    }
}
```

访问：

- `http://localhost:8080/chat?message=查询北京天气`
- `http://localhost:8080/chat?message=查询昌平区到天安门的路线规划`

## 9. A2A

谷歌在2025年4月发布了开源的应用层协议A2A（Agent-to-Agent），其设计目的是使智能体（Agent）之间能够以一种自然的模态进行协作，类似于人与人之间的互动。

![image-20250720191931616](images/image-20250720191931616.png)

## 10. 多模态

**模态**是指表达或感知事物的方式，例如视觉、听觉、嗅觉。对应的信息传递媒介可以是文本、语音、图片、视频等。**多模态**就是从多个模态表达或感知事物。

大模型也可以进行图片处理、图片理解、图片生成、语音合成、语音识别、音频理解、视频理解、视频生成等，支持视觉-语言的多模态任务。

以图片理解为例，我们使用`通义千问VL-Max`（通义千问超大规模视觉语言模型）进行演示，它具有很强的视觉推理能力和指令遵循能力，提供更高的视觉感知和认知水平。

我们新建一个工程，引入依赖：

```xml
<dependency>
    <groupId>dev.langchain4j</groupId>
    <artifactId>langchain4j-open-ai-spring-boot-starter</artifactId>
    <version>1.0.1-beta6</version>
</dependency>
<!-- IO工具 -->
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.13.0</version>
</dependency>
```

配置文件：

```yaml
langchain4j:
  open-ai:
    chat-model:
      base-url: https://dashscope.aliyuncs.com/compatible-mode/v1
      api-key: 你的API-Key
      model-name: qwen-vl-max
      log-requests: true   # 打印请求日志
      log-responses: true  # 打印响应日志
```

测试：

```java
@SpringBootTest
public class AiBootPictureDemoApplicationTests {
    @Autowired
    private OpenAiChatModel model;
    
    @Test
    public void test() throws IOException {
        // 图片的MIME类型
        String mimeType = "image/png";
        // 图片的URL地址
        String imageUrl = "https://oss.itbaima.cn/internal/markdown/2022/09/17/Z7AiBPNO6ylML4z.png";
        // 将图片转换为Base64编码后的结果
        String base64Data = encodePicture(imageUrl);

        // 调用LLM
        UserMessage userMessage = UserMessage.from(
                TextContent.from("描述下这张图片中的内容"),
                ImageContent.from(base64Data, mimeType)
        );
        ChatResponse response = model.chat(userMessage);
        System.out.println(response.aiMessage().text());
    }

    private String encodePicture(String url) throws IOException {
        byte[] imageBytes = IOUtils.toByteArray(new URL(url));
        return Base64.getEncoder().encodeToString(imageBytes);
    }
}
```





