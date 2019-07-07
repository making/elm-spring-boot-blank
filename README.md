# Blank multi project for Spring Boot + Elm

## How to use

### Use Release version

```
mvn archetype:generate\
 -DarchetypeGroupId=am.ik.archetype\
 -DarchetypeArtifactId=elm-spring-boot-blank-archetype\
 -DarchetypeVersion=0.0.1
```

### Use Snapshot version

```
mvn -U org.apache.maven.plugins:maven-archetype-plugin:2.2:generate \
 -DarchetypeRepository=https://oss.sonatype.org/content/repositories/snapshots \
 -DarchetypeGroupId=am.ik.archetype\
 -DarchetypeArtifactId=elm-spring-boot-blank-archetype\
 -DarchetypeVersion=0.0.3-SNAPSHOT
```

## Example

```
$ mvn archetype:generate\
 -DarchetypeGroupId=am.ik.archetype\
 -DarchetypeArtifactId=elm-spring-boot-blank-archetype\
 -DarchetypeVersion=0.0.1\
 -DgroupId=com.example\
 -DartifactId=demo-app\
 -Dversion=1.0-SNAPSHOT\
 -B

cd demo-app
chmod +x ./mvnw*

./mvnw clean package
java -jar demo-app-backend/target/demo-app-backend-1.0-SNAPSHOT.jar
```

![image](https://user-images.githubusercontent.com/106908/60767606-30f05800-a0f5-11e9-846c-c7ac0083d15f.png)


Deploy to Cloud Foundry:

```
cf push
```
