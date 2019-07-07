#!/bin/bash
set -e

KEYWORD="DELETE THIS LINE"

rm -rf $(find . -type d -name target)
rm -rf ./tmp

mkdir tmp
cp -r  pom.xml projectName* .mvn mvnw* .gitignore manifest.yml tmp
pushd tmp
# sed -i.bk "s|projectName|\${artifactId}|g" manifest.yml
# rm -f manifest.yml.bk

TMP_DIR=`pwd`
rm -rf $(find . -type d -name elm-stuff)
rm -rf $(find . -type f -name '*.iml')

mvn org.apache.maven.plugins:maven-archetype-plugin:3.0.1:create-from-project

pushd target/generated-sources/archetype
sed -i.bk "/${KEYWORD}/d" target/classes/archetype-resources/pom.xml
sed -i.bk "s|xxxxxx\.yyyyyy\.zzzzzz|\${package}|g" target/classes/archetype-resources/pom.xml
sed -i.bk "s|xxxxxx\.yyyyyy\.zzzzzz|am.ik.archetype|g" pom.xml
sed -i.bk "s|projectName|elm-spring-boot-blank|g" pom.xml
sed -i.bk "s|<scm>|<distributionManagement><snapshotRepository><id>repo</id><url>https://oss.sonatype.org/content/repositories/snapshots</url></snapshotRepository><repository><id>repo</id><url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url></repository></distributionManagement><scm>|g" pom.xml
sed -i.bk "s|<build>|<build><plugins><plugin><groupId>org.sonatype.plugins</groupId><artifactId>nexus-staging-maven-plugin</artifactId><version>1.6.8</version><extensions>true</extensions><configuration><serverId>repo</serverId><nexusUrl>https://oss.sonatype.org/</nexusUrl><autoReleaseAfterClose>true</autoReleaseAfterClose></configuration></plugin><plugin><groupId>org.apache.maven.plugins</groupId><artifactId>maven-gpg-plugin</artifactId><version>1.6</version><executions><execution><id>sign-artifacts</id><phase>verify</phase><goals><goal>sign</goal></goals></execution></executions></plugin></plugins>|g" pom.xml
sed -i.bk '/<include>\*\*\/\*.json<\/include>/d' ./src/main/resources/META-INF/maven/archetype-metadata.xml
sed -i.bk '/<include>manifest\.yml<\/include>/d' ./src/main/resources/META-INF/maven/archetype-metadata.xml
sed -i.bk 's|<include>\*\*/\*.properties</include>|<include>**/*.properties</include><include>**/*.json</include>|' ./src/main/resources/META-INF/maven/archetype-metadata.xml
sed -i.bk '15,30 s|</fileSets>|<fileSet filtered="true" encoding="UTF-8"><directory></directory><includes><include>manifest.yml</include></includes></fileSet></fileSets>|' ./src/main/resources/META-INF/maven/archetype-metadata.xml

rm -f `find ${TMP_DIR} -name '*.bk'`