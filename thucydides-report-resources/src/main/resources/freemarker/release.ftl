<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8"/>
    <title>${release.name}</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link rel="stylesheet" type="text/css" href="jqplot/jquery.jqplot.min.css"/>
    <style type="text/css">a:link {
        text-decoration: none;
    }

    a:visited {
        text-decoration: none;
    }

    a:hover {
        text-decoration: none;
    }

    a:active {
        text-decoration: none;
    }
    </style>


    <!--[if IE]>
    <script language="javascript" type="text/javascript" src="jit/Extras/excanvas.js"></script><![endif]-->

    <script type="text/javascript" src="scripts/jquery.js"></script>
    <script type="text/javascript" src="datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="jqplot/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="jqplot/plugins/jqplot.pieRenderer.min.js"></script>

    <link type="text/css" href="jqueryui/css/start/jquery-ui-1.8.18.custom.css" rel="Stylesheet"/>
    <script type="text/javascript" src="jqueryui/js/jquery-ui-1.8.18.custom.min.js"></script>

    <script src="jqtree/tree.jquery.js"></script>
    <link rel="stylesheet" href="jqtree/jqtree.css">

    <link rel="stylesheet" href="font-awesome/css/bootstrap.min.css">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
    <!--[if IE 7]>
    <link rel="stylesheet" href="font-awesome/css/font-awesome-ie7.min.css">
    <![endif]-->
    <link rel="stylesheet" href="css/core.css"/>

    <style type="text/css" media="screen">
        .dataTables_info {
            padding-top: 0;
        }

        .dataTables_paginate {
            padding-top: 0;
        }

        .css_right {
            float: right;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".read-more-link").click(function () {
                $(this).nextAll("div.read-more-text").toggle();
                var isrc = $(this).find("img").attr('src');
                if (isrc == 'images/plus.png') {
                    $(this).find("img").attr("src", function () {
                        return "images/minus.png";
                    });
                } else {
                    $(this).find("img").attr("src", function () {
                        return "images/plus.png";
                    });
                }
            });
            // Results table
            $('#req-results-table').dataTable( {
                "aaSorting": [[ 2, "asc" ]],
                "bJQueryUI": true
            } );
        });
    </script>
</head>

<body>
<div id="topheader">
    <div id="topbanner">
        <div id="logo"><a href="index.html"><img src="images/logo.jpg" border="0"/></a></div>
    </div>
</div>


<div class="middlecontent">
    <div id="contenttop">
        <div class="middlebg">
            <span class="bluetext"><a href="releases.html" class="bluetext">Releases</a>
                <#foreach parent in release.parents>
                   >&nbsp<a href="${parent.reportName}">${parent.name}</a>
                </#foreach>
                   >
                ${release.name}
            </span>
        </div>
        <div class="rightbg"></div>
    </div>

    <div class="clr"></div>

    <!--/* starts second table*/-->
    <div class="menu">
        <ul>
            <li><a href="index.html">Test Results</a></li>
            <li><a href="capabilities.html">Requirements</a></li>
            <li><a href="releases.html" class="current">Releases</a></li>
            <li><a href="progress-report.html">Progress</a></li>
        <#foreach tagType in allTestOutcomes.firstClassTagTypes>
            <#assign tagReport = reportName.forTagType(tagType) >
            <#assign tagTypeTitle = inflection.of(tagType).inPluralForm().asATitle() >
            <li><a href="${tagReport}">${tagTypeTitle}</a></li>
        </#foreach>
            <li><a href="history.html">History</a></li>
        </ul>
        <span class="date-and-time">Tests run ${timestamp}</span>
        <br style="clear:left"/>
    </div>

    <div class="clr"></div>


    <div id="beforetable"></div>
    <div id="results-dashboard">
        <div class="middlb">
            <div class="table">

                <div id="releases">
                    <h3>Release Details</h3>
                    <table>
                        <tr>
                            <td valign="top"><a class="label" href="releases.html">Releases</a></td>
                            <td valign="top">
                            <#foreach parent in release.parents>
                                >&nbsp<a class="label" href="${parent.reportName}">${parent.name}</a>
                            </#foreach>
                            &nbsp:
                            </td>
                            <td class="release-context-tree">
                                <div id="release-tree"></div>
                            </td>
                        </tr>
                    </table>

                    <script>
                        var releaseData = ${releaseData};
                        $(function () {
                            $('#release-tree').tree({
                                data: releaseData
                            });
                        });

                        $('#release-tree').bind(
                                'tree.click',
                                function (event) {
                                    window.location.href = event.node.reportName;
                                }
                        );

                    </script>

                    <div id="release-coverage">
                        <div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
                            <ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                                <li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active requirementTitle"><a href="#tabs-1">
                                    ${requirementType}
                                </a></li>
                            </ul>
                            <!----->

                            <div id="tabs-1" class="capabilities-table">
                            <#--- Requirements -->
                                <div id="req_list_tests" class="table">
                                    <div class="test-results">
                                        <table id="req-results-table">
                                            <thead>
                                            <tr>
                                                <th width="40" class="test-results-heading">&nbsp;</th>
                                                <th width="250" class="test-results-heading">${requirementType}</th>
                                                <th width="250"  class="test-results-heading">${secondLevelRequirementType}</th>
                                                <th class="test-results-heading" width="120px">Automated<br/>Tests</th>
                                                <th class="test-results-heading" width="50px"><i class="icon-check icon-large" title="Tests passed (automated)"></i></th>
                                                <th class="test-results-heading" width="50px"><i class="icon-check-empty icon-large" title="Tests skipped or pending (automated)"></th>
                                                <th class="test-results-heading" width="50px"><i class="icon-exclamation-sign icon-large" title="Tests failed (automated)"></th>
                                                <th class="test-results-heading" width="120px">Manual<br/>Tests</th>
                                                <th class="test-results-heading" width="50px"><i class="icon-check icon-large" title="Tests passed (manual)"></i></th>
                                                <th class="test-results-heading" width="50px"><i class="icon-check-empty icon-large" title="Tests skipped or pending (manual)"></th>
                                                <th class="test-results-heading" width="50px"><i class="icon-exclamation-sign icon-large" title="Tests failed (manual)"></th>
                                            </tr>
                                            <tbody>

                                            <#foreach requirementOutcome in requirementOutcomes>
                                                <#if requirementOutcome.testOutcomes.stepCount == 0 || requirementOutcome.testOutcomes.result == "PENDING" || requirementOutcome.testOutcomes.result == "IGNORED">
                                                    <#assign status_icon = "traffic-yellow.gif">
                                                    <#assign status_rank = 0>
                                                <#elseif requirementOutcome.testOutcomes.result == "ERROR">
                                                    <#assign status_icon = "traffic-orange.gif">
                                                    <#assign status_rank = 1>
                                                <#elseif requirementOutcome.testOutcomes.result == "FAILURE">
                                                    <#assign status_icon = "traffic-red.gif">
                                                    <#assign status_rank = 2>
                                                <#elseif requirementOutcome.testOutcomes.result == "SUCCESS">
                                                    <#assign status_icon = "traffic-green.gif">
                                                    <#assign status_rank = 3>
                                                </#if>

                                            <tr class="test-${requirementOutcome.testOutcomes.result} requirementRow">
                                                <td class="requirementRowCell">
                                                    <img src="images/${status_icon}" class="summary-icon" title="${requirementOutcome.testOutcomes.result}"/>
                                                    <span style="display:none">${status_rank}</span>
                                                </td>
                                                <td class="release-title">
                                                    <#assign requirementReport = reportName.forRequirement(requirementOutcome.requirement) >
                                                    <a href="${requirementReport}">${requirementOutcome.requirement.name}</a>
                                                </td>
                                                <td class="release-title">
                                                    <ul class="second-level-requirements">
                                                    <#foreach childRequirement in requirementOutcome.requirement.children>
                                                        <#assign childRequirementReport = reportName.forRequirement(childRequirement) >
                                                        <li><a href="${childRequirementReport}">${childRequirement.name}</a></li>
                                                    </#foreach>
                                                    </ul>
                                                </td>

                                                <#assign totalAutomated = requirementOutcome.tests.count("AUTOMATED").withAnyResult()/>
                                                <#assign automatedPassedPercentage = requirementOutcome.tests.getFormattedPercentage("AUTOMATED").withResult("SUCCESS")/>
                                                <#assign automatedFailedPercentage = requirementOutcome.tests.getFormattedPercentage("AUTOMATED").withFailureOrError()/>
                                                <#assign automatedPendingPercentage = requirementOutcome.tests.getFormattedPercentage("AUTOMATED").withIndeterminateResult()/>
                                                <#assign automatedPassed = requirementOutcome.tests.count("AUTOMATED").withResult("SUCCESS")/>
                                                <#assign automatedPending = requirementOutcome.tests.count("AUTOMATED").withIndeterminateResult()/>
                                                <#assign automatedFailed = requirementOutcome.tests.count("AUTOMATED").withFailureOrError()/>
                                                <#assign totalManual = requirementOutcome.tests.count("MANUAL").withAnyResult()/>
                                                <#assign manualPassedPercentage = requirementOutcome.tests.getFormattedPercentage("MANUAL").withResult("SUCCESS")/>
                                                <#assign manualFailedPercentage = requirementOutcome.tests.getFormattedPercentage("MANUAL").withFailureOrError()/>
                                                <#assign manualPending = requirementOutcome.tests.count("MANUAL").withIndeterminateResult()/>
                                                <#assign manualPendingPercentage = requirementOutcome.tests.getFormattedPercentage("MANUAL").withIndeterminateResult()/>
                                                <#assign manualPassed = requirementOutcome.tests.count("MANUAL").withResult("SUCCESS")/>
                                                <#assign manualFailed = requirementOutcome.tests.count("MANUAL").withFailureOrError()/>

                                                <td class="greentext">${totalAutomated}<div class="small">(${automatedPassedPercentage} pass)</div></td>
                                                <td class="greentext">${automatedPassed}</td>
                                                <td class="bluetext">${automatedPending}</td>
                                                <td class="redtext">${automatedFailed}</td>
                                                <td class="greentext">${totalManual}<div class="small">(${manualPassedPercentage} pass)</div></td>
                                                <td class="greentext">${manualPassed}</td>
                                                <td class="bluetext">${manualPending}</td>
                                                <td class="redtext">${manualFailed}</td>
                                            </tr>
                                            </#foreach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!----->


            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>
<div id="beforefooter"></div>
<div id="bottomfooter"></div>

</body>
</html>
