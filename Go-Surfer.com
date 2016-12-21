
Microsoft Visual Studio Solution File, Format Version 12.00
# Visual Studio 14
VisualStudioVersion = 14.0.24720.0
MinimumVisualStudioVersion = 10.0.40219.1
Project("{E24C65DC-7377-472B-9ABA-BC803B73C61A}") = "Go-Surfer.com(1)", ".", "{ADE4BED6-201F-476F-B9B4-D829B8E9D52F}"
	ProjectSection(WebsiteProperties) = preProject
		TargetFrameworkMoniker = ".NETFramework,Version%3Dv4.0"
		Debug.AspNetCompiler.VirtualPath = "/localhost_21129"
		Debug.AspNetCompiler.PhysicalPath = "..\..\..\..\Dropbox\Education\CIS 2350\Go-Surfer.com\"
		Debug.AspNetCompiler.TargetPath = "PrecompiledWeb\localhost_21129\"
		Debug.AspNetCompiler.Updateable = "true"
		Debug.AspNetCompiler.ForceOverwrite = "true"
		Debug.AspNetCompiler.FixedNames = "false"
		Debug.AspNetCompiler.Debug = "True"
		Release.AspNetCompiler.VirtualPath = "/localhost_21129"
		Release.AspNetCompiler.PhysicalPath = "..\..\..\..\Dropbox\Education\CIS 2350\Go-Surfer.com\"
		Release.AspNetCompiler.TargetPath = "PrecompiledWeb\localhost_21129\"
		Release.AspNetCompiler.Updateable = "true"
		Release.AspNetCompiler.ForceOverwrite = "true"
		Release.AspNetCompiler.FixedNames = "false"
		Release.AspNetCompiler.Debug = "False"
		VWDPort = "21129"
	EndProjectSection
EndProject
Global
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{ADE4BED6-201F-476F-B9B4-D829B8E9D52F}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{ADE4BED6-201F-476F-B9B4-D829B8E9D52F}.Debug|Any CPU.Build.0 = Debug|Any CPU
	EndGlobalSection
	GlobalSection(SolutionProperties) = preSolution
		HideSolutionNode = FALSE
	EndGlobalSection
EndGlobal
