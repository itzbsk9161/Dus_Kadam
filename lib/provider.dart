import 'package:flutter/material.dart';

class getx extends StatefulWidget {
  const getx({super.key});

  @override
  State<getx> createState() => _getxState();
}

class _getxState extends State<getx> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
      //what is provider?'
        'provider is a way to pass data between UI oR widget tree'
      //why we need provider?
        '1-Better performance'
        '2-easy to handled the data'
        '3-update data in real-time'
        '4-production level app'
      //flutter providers
      'provider,listenableprovider,changenotifierprovider,valuelistenableprovider,dtream provider,multiprovider'



//  Key Components and Services:
//   Compute Services:
//      Virtual Machines (VMs): Allows users to run virtualized Windows or Linux servers in the cloud.
//      Azure Kubernetes Service (AKS): A managed Kubernetes service for deploying, managing, and
//         scaling containerized applications.
//
// Storage Services:
//     Azure Blob Storage: Object storage service for storing and retrieving large amounts of unstructured data.
//     Azure File Storage: Fully managed file shares that can be accessed using the standard Server Message
//         Block (SMB) protocol.
//     Azure Table Storage: NoSQL data store suitable for semi-structured data.
//
// Database Services:
//     Azure SQL Database: Fully managed relational database service.
//     Azure Cosmos DB: Globally distributed, multi-model database service designed for high performance and
//     scalability.
//     Azure Redis Cache: In-memory data store used for caching.
//
// Networking:
//     Azure Virtual Network: Provides private and isolated network environments in the Azure cloud.
//     Azure Load Balancer: Distributes network traffic across multiple servers.
//     Azure VPN Gateway: Enables secure connections between on-premises networks and Azure.
//     Identity and Access Management:
//
//     Azure Active Directory (AD): Cloud-based identity and access management service.
//     Azure Multi-Factor Authentication: Adds an additional layer of security to user sign-ins.
//     Developer Tools:
//
//     Azure DevOps: A set of development tools for planning, developing, testing, and delivering applications.
//     AI and Machine Learning:
//
//     Azure Machine Learning: Provides tools and services for building, training, and deploying machine learning models.
//     Cognitive Services: A set of APIs and services for adding intelligent features to applications.
//     Internet of Things (IoT):
//
//     Azure IoT Hub: Managed service for connecting, monitoring, and managing IoT devices.
//     Security and Compliance:
//
//     Azure Security Center: Unified security management system that strengthens the security posture of your
//     data centers.
//
// Management and Monitoring:
//     Azure Monitor: Comprehensive solution for collecting, analyzing, and acting on telemetry data from
//     applications running in Azure.
//
//  Advantages of Azure Cloud:
//     Scalability and Flexibility:
//     Azure allows users to scale resources up or down based on demand, providing flexibility and cost efficiency.
//
//     Global Reach:
//     Azure has data centers located worldwide, enabling users to deploy applications and services close to their end-users for improved performance.
//
//     Hybrid Cloud Capability:
//     Azure supports hybrid cloud scenarios, allowing businesses to integrate on-premises data centers with cloud services.
//
//     Security and Compliance:
//     Azure provides a range of security features and compliance certifications to help safeguard data and applications.
//
//     Integration with Microsoft Products:
//     Seamless integration with Microsoft products such as Windows Server, Active Directory, and Visual Studio.
//
//     Pay-as-You-Go Pricing Model:
//     Users pay for the resources they consume, promoting cost-effectiveness.
//
//        IaaS - Infrastructure as a Service:
//         Definition: IaaS provides virtualized computing resources over the internet. It allows users
//         to rent virtual machines, storage, and networking components on a pay-as-you-go basis.
//         Example in Azure: Azure Virtual Machines (VMs) fall under IaaS. Users can deploy and manage
//         VMs running Windows or Linux, providing control over the operating system, applications, and
//         networking.

//         PaaS - Platform as a Service:
//         Definition: PaaS provides a platform that includes infrastructure and runtime services to
//         develop, test, and deploy applications without managing the underlying infrastructure.
//         Developers focus on writing code and don't worry about server management.
//         Example in Azure: Azure App Service is an example of PaaS. It allows developers to build,
//         deploy, and scale web apps quickly. Azure takes care of the underlying infrastructure,
//         including servers, networking, and load balancing.

//         SaaS - Software as a Service:
//         Definition: SaaS delivers software applications over the internet on a subscription basis.
//         Users can access the software through a web browser without worrying about installation,
//         maintenance, or infrastructure management.
//         Example in Azure: While Azure itself primarily provides infrastructure and platform services,
//         third-party software running on Azure can be considered SaaS. For instance, Microsoft 365
//         (formerly Office 365) applications like Microsoft Word, Excel, and Outlook are SaaS offerings
//         available on the Azure platform.
//
//     IaaS provides virtualized infrastructure components like virtual machines, storage, and networking.
//     PaaS provides a platform and runtime for application development, abstracting away infrastructure management.
//     SaaS delivers fully functional software applications over the internet, eliminating the need for users to manage infrastructure or perform installations.
    ),
        ) ,
    );
  }
}
