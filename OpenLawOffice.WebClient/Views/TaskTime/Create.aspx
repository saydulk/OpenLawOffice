﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteNoRightBar.Master" Inherits="System.Web.Mvc.ViewPage<OpenLawOffice.WebClient.ViewModels.Tasks.TaskTimeViewModel>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    New Time Entry
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="/Scripts/moment.min.js"></script>

    <div id="roadmap">
        <div class="zero">Matter: [<%: Html.ActionLink((string)ViewData["Matter"], "Details", "Matters", new { id = ViewData["MatterId"] }, null) %>]</div>
        <div class="one">Task: [<%: Html.ActionLink((string)ViewData["Task"], "Details", "Tasks", new { id = ViewData["TaskId"] }, null) %>]</div>
        <div id="current" class="two">New Time Entry<a id="pageInfo" class="btn-question" style="padding-left: 15px;">Help</a></div>
    </div>
    
    <% using (Html.BeginForm())
       {%>
    <%: Html.ValidationSummary(true) %>
    <% if (ViewData["ErrorMessage"] != null)
       { %>
        <div style="color: Red;"><%= ViewData["ErrorMessage"]%></div>
    <% } %>
    <table class="detail_table">
        <tr>
            <td class="display-label">
                Task
            </td>
            <td class="display-field">
                <%: Html.HiddenFor(model => model.Task.Id) %>
                <%: Model.Task.Title %>
            </td>
        </tr>
        <tr>
            <td class="display-label">
                Worker
            </td>
            <td class="display-field">
                <%: Html.HiddenFor(model => model.Time.Worker.Id) %>
                <%: Model.Time.Worker.DisplayName %>
            </td>
        </tr>
        <tr>
            <td class="display-label">
                Billable<span class="required-field" title="Required Field">*</span>
            </td>
            <td class="display-field">
                <%: Html.CheckBoxFor(model => model.Time.Billable)%>
                Check if time is billable.
            </td>
        </tr>
        <tr>
            <td class="display-label">
                Start Date/Time<span class="required-field" title="Required Field">*</span>
            </td>
            <td class="display-field">
                <%: Html.TextBoxFor(model => model.Time.Start, new { @Value = Model.Time.Start.ToString("M/d/yyyy h:mm tt") })%>
                <%: Html.ValidationMessageFor(model => model.Time.Start)%>
            </td>
        </tr>
        <tr>
            <td class="display-label">
                Stop Date/Time<span class="required-field" title="Required Field">*</span>
            </td>
            <td class="display-field">
                <%: Html.TextBoxFor(model => model.Time.Stop)%>
                <img id="timeadvance" src="../../Content/fugue-icons-3.5.6/icons-shadowless/hourglass-select.png" style="cursor: pointer" alt="Advance Time" />
                <script language="javascript">
                    $(document).ready(function () {
                        $('#timeadvance').click(function () {
                            var stop, duration;
                            var start = moment($('#Time_Start').val());

                            if (moment($('#Time_Start').val()) > moment()) { // time entry in the future, must treat differently
                                stop = moment(start).add(6, 'minutes').format('M/D/YYYY h:mm A');
                            }
                            else {
                                if ($('#Time_Stop').val() == '') {
                                    duration = moment().diff(start, 'minutes');
                                }
                                else {
                                    stop = moment($('#Time_Stop').val());
                                    duration = stop.diff(start, 'minutes');
                                }
                                var minutesToAdd = 6 - (duration % 6);
                                stop = moment(stop).add(minutesToAdd, 'minutes').format('M/D/YYYY h:mm A');
                            }
                            $('#Time_Stop').val(stop)
                        });
                    });
                </script>
                
                <%: Html.ValidationMessageFor(model => model.Time.Stop)%>
            </td>
        </tr>
        <tr>
            <td class="display-label">
                Details
            </td>
            <td class="display-field">
                <%: Html.TextAreaFor(model => model.Time.Details)%>
                <%: Html.ValidationMessageFor(model => model.Time.Details)%>
            </td>
        </tr>
    </table>
    <p>
        <input type="submit" value="Save" />
    </p>
    <% } %>
    <div id="pageInfoDialog" title="Help">
        <p>
        <span style="font-weight: bold; text-decoration: underline;">Info:</span>
        Fill in the information on this page to create a new time entry for the task.  Required fields are indicated with an
        <span style="color: #ee0000;font-size: 12px;cursor:help;" title="Required Field">*</span><br /><br />
        <span style="font-weight: bold; text-decoration: underline;">Usage:</span>
        Fields marked with an <span style="color: #ee0000;font-size: 12px;cursor:help;" title="Required Field">*</span> are required.
        </p>
    </div>
</asp:Content>