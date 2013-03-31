﻿using System;
using System.Windows.Controls;
using System.Windows;

namespace OpenLawOffice.WinClient.Controls
{
    /// <summary>
    /// Interaction logic for TreeGridView.xaml
    /// </summary>
    public partial class TreeGridView : UserControl
    {
        public Action<TreeGridView, object> OnSelectionChanged { get; set; }
        public Action<TreeGridView> OnLoad { get; set; }

        public TreeGridView()
        {
            InitializeComponent();
            UITree.AddHandler(TreeViewItem.ExpandedEvent, new RoutedEventHandler(TreeViewItemExpanded));
            DataContextChanged += new DependencyPropertyChangedEventHandler(TreeGridView_DataContextChanged);
        }

        void TreeGridView_DataContextChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            string a = " ";
        }

        public TreeGridView SetExpanderColumnTemplate(string header, string textBindingPath, double width = Double.NaN)
        {
            string xaml = string.Format(@"<DataTemplate 
                    xmlns=""http://schemas.microsoft.com/winfx/2006/xaml/presentation""
                    xmlns:x=""http://schemas.microsoft.com/winfx/2006/xaml""
                    xmlns:toolkit=""clr-namespace:DW.WPFToolkit;assembly=DW.WPFToolkit"">
                    <DockPanel>
                        <toolkit:TreeListViewExpander DockPanel.Dock=""Left"" />
                        <TextBlock Text=""{{Binding {0}}}"" Margin=""5,0,0,0"" />
                    </DockPanel>
                </DataTemplate>", textBindingPath);

            ExpanderColumn.Header = header;
            ExpanderColumn.CellTemplate = (DataTemplate)System.Windows.Markup.XamlReader.Parse(xaml);
            ExpanderColumn.Width = width;

            return this;
        }

        public TreeGridView AddColumn(GridViewColumn column)
        {
            UIGridView.Columns.Add(column);
            return this;
        }

        public TreeGridView AddResource(Type dataType, object resource)
        {
            UITree.Resources.Add(new DataTemplateKey(dataType), resource);
            return this;
        }

        public object GetSelectedItem()
        {
            return UITree.SelectedItem;
        }

        private void TreeViewItemExpanded(object sender, RoutedEventArgs e)
        {
            DW.WPFToolkit.TreeListViewItem treeItem = (DW.WPFToolkit.TreeListViewItem)e.OriginalSource;

            ControllerManager.Instance.GetData((ViewModels.IViewModel)treeItem.DataContext);
        }
    }
}