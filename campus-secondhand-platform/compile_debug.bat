@echo off
chcp 65001 >nul
echo === 开始编译 ===
echo 当前目录：%CD%
echo.

:: 设置 JDK 17 环境
set JAVA_HOME=D:\Java\jdk-17
echo JAVA_HOME 设置为: %JAVA_HOME%
echo.

:: 验证 Java 路径是否存在
if not exist "%JAVA_HOME%\bin\java.exe" (
    echo 错误: Java 运行时不存在于 %JAVA_HOME%\bin\java.exe
    exit /b 1
)

:: 更新 PATH，确保优先使用 JDK 17
set PATH=%JAVA_HOME%\bin;%PATH%
echo 更新后的 PATH (前 200 字符): %PATH:~0,200%
echo.

:: 检查 Java 版本
echo === 检查 Java 版本 ===
"%JAVA_HOME%\bin\java.exe" -version
echo.

:: 验证 Maven 路径
set MAVEN_HOME=D:\java-web\develop\apache-maven-3.9.4
echo MAVEN_HOME 设置为: %MAVEN_HOME%
if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
    echo 错误: Maven 不存在于 %MAVEN_HOME%\bin\mvn.cmd
    exit /b 1
)
echo.

:: 执行 Maven 编译
echo === 开始 Maven 编译 ===
echo 执行命令: call "%MAVEN_HOME%\bin\mvn.cmd" clean compile
call "%MAVEN_HOME%\bin\mvn.cmd" clean compile
exit /b %ERRORLEVEL%
