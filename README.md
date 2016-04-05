##微信公众号:

![学习流程图](https://github.com/minggo620/iOSRuntimeLearn/blob/master/picture/gongzhonghao.jpg?raw=true)
#谈KVC、KVO（重点观察者模式）机制编程
[![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSObserving.git)  
一不小心，小明在《跟着贝尔去冒险》这个真人秀节目中看到了“一日警察，一世警察”的Laughing哥，整个节目除了贝尔吃牛睾丸都不用刀叉的不雅餐饮文化外，还是镜头少普通话跟小明一样烂的Laughing Sir那种冷静和沉着稳定留下了深刻印象，不由想起电视剧《学警狙击》中为了不暴露钟立文的身份，要求向自己补一枪的警匪卧底巅峰推动者--Laughing 哥。
那么，卧底这样的工作，在我们程序里有没有呢？答案是肯定的，观察者模式。


![文章内容思维导图](http://upload-images.jianshu.io/upload_images/1252638-2d492cca12bcbd50.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###一.基本概念
#####1）KVC概念
>1. KVC全称Key-value coding.
2. 一个非正式的Protocol，提供一种机制来间接访问对象的属性.  
**官方文档提供对KVC很准确的描述**  
>Key-value coding is a mechanism for accessing an object’s properties indirectly, using strings to identify properties, rather than through invocation of an accessor method or accessing them directly through instance variables. In essence, key-value coding defines the patterns and method signatures that your application’s accessor methods implement.

#####2）KVO概念
>1. KVO全称Key-Value Observing。
2. 典型的观察者模式承载者。
3. 基于监控键值发生变化，通知观察者。
4. KVO 就是基于 KVC 实现的关键技术之一。  
**官方文档提供对KVO很准确的描述**  
>Key-value observing provides a mechanism that allows objects to be notified of changes to specific properties of other objects. It is particularly useful for communication between model and controller layers in an application. 

###二.KVC和KVO的作用
>Laughing哥上场了，先看看怎么做卧底，首先，Laughing哥先得符合古惑仔行为准则混入黑帮；接着，除了放高利贷和Disco业务外最重的是挤兑从台湾出狱的世孝，选择站在亦天内心的一边得到足够多的信任；最后，凭借“一日警察，一世警察”赤诚初心，秉公执法端掉亦天和制毒窝点。

那么，你觉度Laughing Sir的作用是什么？

**1. 接近需要得到信息隐秘或不隐秘的使用场所。**  
**2. 直接监视信息的变化。**  
**3. 当产生了有用的信息后，那马上通知汇报。**

如果亦天制作的毒品比作信息，普通警察只能通过get方式属性，更重要是不知道他什么时候发生了变化。卧底Laughing Sir完美扮演的就是KVC和KVO机制，为什么说完美？KVC是可以直接通过路径获取对应的键的值，KVO的观察通知部分就对应Laughing Sir的监视和汇报，如果Laughing Sir变节了或者没有意志做下去了，那就只能是KVC能获取到信息，但不能通知上级信息的变化，就没有了一个经典的卧底角色Laughing了。  
###三.JAVA中的观察着模式  
Sun公司早早就把观察者模式视为重要的模式，并在Java中提供方便的接口Observer和类Observable。这个地方注意一下，Observer是一个接口，Observable是一个类。因为很容易先入为主，XXXable第一反应是接口。如果看过《设计模式之禅》这本书的人，自然想起书中举的例子是李斯监视同窗韩非子的一举一动汇报给秦始皇。并且书中的Observer和Observable自定义定义刚好相反，注意下即可。为什么提Java，继续看吧。

###四.代码实现  
####1. KVC属性读取和修改
#####1）Sense：  
	警官：梁笑棠，从今天开始 ，你的生命属于社会的，清楚吗？  
	Laughing Sir：清楚。  
	警官：出了这个学堂，你要叫Laughing 哥，记好了吗？  
	Laughing Sir：Yes sir。
	警官：你妹，大声点。  
	Laughing Sir：_____

程序中，Laughing Sir被派于卧底工作前，需要把`Laughing Sir`的名字属性值更换成`Laughing哥`.我们就从这个地方开始练练手预热做卧底的体验吧。
#####2）Step：
①通过路径方式获取属性值    
	
	NSString *preName = [laughingSir valueForKey:@"name"];

②修改属性值
	
	[laughingSir setValue:@"laughing 哥" forKey:@"name"];  

#####3）Show Code：  
	
	NSString* exchangeName(LaughingSir *laughingSir){
    
    	NSString *preName = [laughingSir valueForKey:@"name"];
    	NSLog(@"laughing的旧名字：%@",preName);
    
    	[laughingSir setValue:@"laughing 哥" forKey:@"name"];
    
    	NSString *newName = [laughingSir valueForKey:@"name"];
    	NSLog(@"laughing的新名字：%@",newName);
    
    	return newName;
	}


####2.KVO观察者模式演绎
#####1）Sense:  
	亦天可能进行制毒。。。
	Laughing Sir开始监控亦天
	报告上级亦天制毒数：___  
程序中，Laughing Sir开始观察YiTian这个实体类中的narcotics属性，一旦亦天制作出毒品，就马上observeValueForKeyPath通知上级，看看如下的具体实现。
#####2）Step：
①对被观察者添加观察  
	
	[self.yiTian addObserver:self forKeyPath:@"narcotics" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];  

②实现观察结果处理方法  
	
	-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
		//汇报上级
	}

#####3）Show Code：
	
	-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
		if([keyPath isEqualToString:@"narcotics"]){
        
        	NSNumber *narcoticsN = [change objectForKey:@"new"];//修改之后的最新值
        	NSInteger narcotics = [narcoticsN integerValue];
        	if (narcotics>0) {
            	if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(reportYitian:)]) {
                	[self.delegate reportYitian:narcotics];
            	}
        	}
    	}
	}  
注意：留意下[change objectForKey:@"new"]其中这个new是指新赋予narcotics这个属性的值，当然也有一个old而不是[change objectForKey:@"narcotics"]；narcotics是毒品意思。

####3.Java实现观察者模式
这里我就直接显示关键代码了，不做过多说明，对比了解和学习。  

	/**
	* 亦天实体类  
	* @author minggo
	* @time 2016年4月1日 上午10:24:15
	 */
	public class YITian extends Observable {

		private Observer observer;
		private int narcotics;
	
		@Override
		public synchronized void addObserver(Observer o) {
			super.addObserver(o);
			this.observer = o;
		}
	
		public void MakeNarcotics(){
			for (int i = 0; i <3; i++) {
				narcotics++;
				if (observer!=null) {
					observer.update(this, narcotics);
				}
			}
		}

	}
留意Laughing Sir实体类的@override方法
	
	/**  
	* Laughing Sir实体类  
	* @author minggo  
	* @time 2016年4月1日 上午9:58:36  
	*/
	public class LaughingSir implements Observer{
		@Override
		public void update(Observable o, Object arg) {
			if (o instanceof YITian) {
				System.out.println("监视到亦天制毒"+arg+"kg");
			}
		}
		public void watchOverYiTian(YITian yiTian){
			yiTian.addObserver(this);
		}
	}

最后是测试main方法  
	
	/**  
	* 观察者模式
	* @author minggo
	* @time 2016年4月1日 上午10:36:37
	*/
	public class TestOberving {

		public static void main(String[] args) {
		
			YITian yiTian = new YITian();
			LaughingSir laughingSir = new LaughingSir();
		
			//Laughing Sir卧底开始监视亦天的一举一动
			laughingSir.watchOverYiTian(yiTian);
			System.out.println("Laughing Sir卧底开始监视亦天的一举一动");
		
			System.out.println("-----------亦天开始制作毒品--------");
			//亦天开始制毒
			yiTian.MakeNarcotics();
			System.out.println("-----------亦天结束制作毒品--------");
		}
	}

###五.现状下观察者模式的重要性	
就犹如Laughing哥这样的角色，观察者模式在实际应用中起到重要的作用。无论你之前发现了，还是现在察觉到它的不可忽视。移动开发的MVVM开发架构思想中的重要解耦页面部分，就是观察者模式实现数据绑定，即时刷新数据。这个在iOS中KVO和Android使用Java的Observer接口都异曲同工之意，RxJava的响应是编程的基本思想也是观察者模式之艺术。   
 
现状下的热门的移动开发的关键字，透漏出观察者模式显得越来越重要。其中就包括面试门槛，曾经面试过Android开发者还是iOS开发者，问到观察者这个模式可有了解？有回答iOS观察就是KVO，Java的就是在被观察对象添加回调接口，也有说过《设计模式之禅》中的韩非子被李斯监视的例子。

今天，有多了一个，Laughing哥卧底神话，个人感情建议使用这个例子，呵呵~。

###六.效果图更直观
![效果图](http://upload-images.jianshu.io/upload_images/1252638-596cd6fc268d7d51.gif?imageMogr2/auto-orient/strip)
###七.源码下载地址更详细
#####*[https://github.com/minggo620/iOSObserving.git](https://github.com/minggo620/iOSObserving.git)*

####Laughing哥如果见到我，估计会说：“小明，其实我真实的名字叫~谢天华！”








