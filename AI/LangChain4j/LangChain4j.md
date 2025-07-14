# 第01章_AI简介

## 1. AI发展史

AI，全名叫Artificial Intelligence，翻译过来就是人工智能，它的本意是让机器能够像人类一样思考、学习和解决问题。

人工智能最早可以追溯到1950年的图灵测试，图灵测试中有两种角色：被测试者和测试者，其中被测试者又分为机器和真人。测试者和被测试者通过文本进行沟通，在真实测试中，被测试者和测试者分别处在不同的房间中，这样测试者无法事先知道被测试者是人还是机器。在沟通的过程中，测试者需要根据接收到的文本信息，判断发送该文本信息的是机器还是人。假设机器给测试者发送了一段文本，但测试者判断的答案是人，这就说明测试者无法分辨清楚机器与人。这个时候，我们就可以说机器具有了人的智能。

人工智能的发展历程主要经过了三个阶段：符号主义、连接主义、神经网络。

### 1.1 符号主义

符号主义实现人工智能，主要分为三个步骤：

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

每个感知机会结合用户的输入、权重、激活函数，与阈值进行比较，得到最终的输出。其中，阈值更专业的名称叫做**偏置**。每个神经元上使用的权重和偏置，我们称之为**参数**。因此，每个神经元上的`参数数量=权重数量+1`，这里的1就是偏置。

整个神经网络中的参数特别特别多，所以我们无法去手动设置这么多的参数。因此我们会通过一个软件去实现神经网络，我们事先准备好一些数据交给这个软件，让它根据我们提供的数据进行学习并自主地设置好神经网络中需要的成千上万的参数。在AI领域，我们将这个实现了神经网络的软件称为**模型**。

OpenAI公司有一个出名的模型叫做GPT，研发人员通过将参数规模从10B提高到100B（1B就是10亿），从而使得GPT模型展现出了通用任务的处理能力。现在，我们通常会把参数规模在1000亿以上的模型，称为**大模型**。

随着GPT模型的爆火，全球各大公司也纷纷跟进，推出了自己的大模型，比如智普AI的ChatGLM，阿里的Qwen，百度的Ernie，Anthropic公司的Cloude，元宇宙的Llma，马斯克的Grok等。不同公司的不同模型，也有不同的擅长领域，比如文本生成、图片生成、视频生成、音频合成、音频理解、视频理解、图片处理、语音识别等等。

## 3. AI市场分布

目前AI主要分为三个赛道：基础算力、核心算法、智能应用。

### 3.1 基础算力

基础算力，就是为大模型提供计算能力。通常都是英伟达、微软、阿里等超大公司参与这个赛道，它们通过芯片、云计算等来为大模型提供更强的算力。

### 3.2 核心算法

这个赛道主要研究开发大模型所需要的算法以及算法框架，比如transformer、pytoch、Tensorflow等等，其中比较知名的公司有OpenAI、深度求索、Meta、Google等等。

### 3.3 智能应用

参与这个赛道的人是最多的，通过借助大模型的能力来将各行各业的软件进行智能化的升级和改造，比如零售、旅游、金融等等。

大模型本质上是一个实现了一些数学模型的软件，对于普通人而言是无法直接使用的。如果我们要对传统的软件做智能化升级改造，我们就需要将大模型接入到传统的软件中，借助于大模型的能力，让软件的功能变得更强大更智能，这就是所谓的智能应用（它也有另外一种主流的叫法：Agent）。



# 第02章_大模型的基本使用

## 1. 大模型部署

### 1.1 本地部署大模型

我们可以本地部署大模型并使用，Ollama工具为我们提供了一键下载并运行大模型的功能，所以我们使用Ollama来本地部署大模型。

（1）前往官网 https://ollama.com/ 下载安装Ollama

（2）从官网 https://ollama.com/search 选择一个想要的大模型（我们以qwen3为例），进入详情页后根据需求选择参数规模，然后在cmd中执行对应命令，就可以运行大模型了：

```cmd
ollama run qwen3:0.6b
```

（3）接着就可以跟本地部署的大模型进行对话，如果想退出聊天则输入`/bye`即可

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

我们也可以直接使用云平台大模型，以阿里云百炼平台为例，需要做如下步骤：

（1）登录阿里云官网 https://aliyun.com

（2）开通大模型服务平台百炼服务

![1748054174911](images/1748054174911.png)

（3）点击`免费体验->模型广场->API-Key`，然后创建API-Key

![image-20250705174444327](images/image-20250705174444327.png)

（4）在模型广场中选择自己想要的大模型，点击API参考，查看使用方法。我们以通义千问-Plus为例，发送POST请求即可进行调用

![image-20250705180015560](images/image-20250705180015560.png)

## 2. 大模型调用

大模型调用时，不同平台的请求数据基本都类似，以下我们将介绍几个核心的数据。

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
- system：模型的目标或角色（可选，如果设置system消息则必须将其放在messages列表的第一位）。用于给大模型设定一个角色，然后大模型就可以用该角色的口吻跟用户对话了。
- assistant：模型对用户消息的回复（可选）。大模型是没有记忆能力的（用户与大模型的每次对话都是独立的），所以如果希望大模型能根据以往的聊天信息而进行推断，就需要将之前用户的问题和大模型的回复也一并发送给大模型。

#### stream

可选参数，`boolean`，默认为false

- true：流式调用，即大模型每生成一部分内容就立即输出一个片段
- false：阻塞式调用，即大模型生成完所有内容后一次性返回结果

#### enable_search

可选参数，`boolean`，默认为false。模型在生成文本时是否使用互联网搜索结果进行参考。

> 说明：由于大模型训练完毕后，它的知识库就不再更新了，比如大模型是2023年10月训练完毕的，那么2023年10月以后新产生的数据，大模型就无法感知了。如果要让大模型可以根据最新的数据回答问题，其中有一种解决方案就是开启联网搜索，大模型就可以根据联网搜索的结果生成最终的答案。

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

> 说明：在大语言模型中，**token**是大模型处理文本的基本单位，可以理解为模型"看得懂"的最小文本片段，用户输入的内容都需要通过分词器转换成token，才能让大模型更好的处理。不同的分词器将同一文本转化成token的个数不完全一致，但对于目前大部分分词器而言，4个英文字符约等于1个token，1个中文字符约等于1~2个token。



# 第03章_LangChain4j

## 1. 快速入门

目前市面上使用Java调用大模型的工具库主流有两种：LangChain4j和Spring AI。其中，LangChain4j的官方文档为 https://docs.langchain4j.dev/

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

## 3. 流式调用

我们之前代码演示的都是阻塞式调用，如果想进行流式调用，则需要使用webflux框架。

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

## 4. 消息注解

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

> 说明：必须使用唯一ID来标识每一次会话，因为用户点击新建会话时就应该使用新的会话记忆，而不是沿用旧的会话记忆。

**整体流程**：当用户发送问题时，LangChain4j会将该消息存储到指定ID的ChatMemory中，然后获取该ID保存的所有消息并发送给大模型；大模型生成文本后会将响应消息也存储到指定ID的ChatMemory中，然后响应用户。

我们可以使用ChatMemory的一个实现类MessageWindowChatMemory来实现会话记忆：

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

由于大模型训练完毕后，它的知识库就不再更新了，也就是说它无法感知今年最新的相关数据（例如今年各个高校的最新录取分数）。一个方案是开启联网搜索。但是对于一些专业领域的数据（例如公司内部某个方案的执行计划），那么对通用大模型而言，开启联网搜索也无法感知。因此，一种更好的策略就是RAG。

RAG全称为Retrieval Augmented Generation（**检索增强生成**），简单理解就是通过检索外部知识库的方式增强大模型的生成能力。

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

在向量数据库中，两个向量的接近程度采用**余弦相似度**来衡量，余弦相似度就是两个向量夹角的余弦值，所以余弦相似度越大（越接近1），两个向量就越接近。从向量数据库中检索与用户问题相关的数据片段的**基本原理**如下：

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

Tools工具，以前也叫做function calling。如果在我们的程序中添加了Tools功能，那么整个工作流程就会变成以下情形：

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



