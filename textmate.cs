using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Transactions;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;
using ;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using System.Timers;
using System.Windows.Automation;

public class Snippet
{
    public string Content { get; set; }
    public List<string> Placeholders { get; set; }
}

public class SnippetManager
{
    private List<Snippet> snippets = new List<Snippet>();

    public void AddSnippet(string name, string content, List<string> placeholders)
    {
        snippets.Add(new Snippet { Content = content, Placeholders = placeholders });
    }

    public string InsertSnippet(string name, string selectedText)
    {
        var snippet = snippets.Find(sn => sn.Name == name);
        if (snippet == null) return null;

        var result = snippet.Content;
        foreach (var placeholder in snippet.Placeholders)
        {
            result = result.Replace(placeholder, selectedText);
        }
        return result;
    }
}

