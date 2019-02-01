node {

   stage 'checkout'

   // Get some code from a GitHub repository
   git url: 'https://github.com/gopac25/mavenrepo_sample.git'
   sh 'git clean -fdx; sleep 4;'

   // Get the maven tool.
   // ** NOTE: This 'mvn' maven tool must be configured
   // **       in the global configuration.
   def mvnHome = tool 'M3'
   
   //stage('SonarQube analysis') {
    //withSonarQubeEnv('sonar') {
      // requires SonarQube Scanner for Maven 3.2+
     // sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2:sonar'
   // }
 // }
   stage 'clean'
   sh "${mvnHome}/bin/mvn clean"
   
   stage 'compile'
   sh "${mvnHome}/bin/mvn compile"
   
   stage 'sonar'
   sh "${mvnHome}/bin/mvn sonar:sonar"
   
   stage 'build'
   // set the version of the build artifact to the Jenkins BUILD_NUMBER so you can
   // map artifacts to Jenkins builds
   sh "${mvnHome}/bin/mvn versions:set -DnewVersion=${env.BUILD_NUMBER}"
   sh "${mvnHome}/bin/mvn package"
  
   stage 'test'
   parallel 'test': {
     sh "${mvnHome}/bin/mvn test; sleep 2;"
   }, 'verify': {
     sh "${mvnHome}/bin/mvn verify; sleep 3"
   }
   
   stage 'junit' {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   
      stage('publishHTML') {
      junit '**/target/surefire-reports/TEST-*.xml'
      archive 'target/*.jar'
   }
   
   stage 'deploy'
   sh "${mvnHome}/bin/mvn deploy"
}
