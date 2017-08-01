using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Biofarma.Presentation.Component
{
    public class Javascript
    {
        private static String SetCoreScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/lib/jquery.js'></script>                         ");
            sb.Append("<script src='../../Scripts/UserPanel/js/lib/jquery-1.8.3.min.js'></script>                                                            ");
            sb.Append("<script src='../../Scripts/UserPanel/bs3/js/bootstrap.min.js'></script>                                                               ");
            sb.Append("<script class='include' type='text/javascript' src='../../Scripts/UserPanel/js/accordion-menu/jquery.dcjqaccordion.2.7.js'></script>  ");
            sb.Append("<script src='../../Scripts/UserPanel/js/lib/jquery-ui-1.9.2.custom.min.js'></script>");
            sb.Append("<script src='../../Scripts/UserPanel/js/scrollTo/jquery.scrollTo.min.js'></script>                                                    ");
            sb.Append("<script src='../../Scripts/UserPanel/js/nicescroll/jquery.nicescroll.js' type='text/javascript'></script>							   ");
            return sb.ToString();
        }

        public static String GetCoreScript()
        {
            return SetCoreScript();
        }

        private static String SetDynamicTableScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<!--dynamic table-->																			                                       ");
            sb.Append("<script type='text/javascript' language='javascript' src='../../Scripts/UserPanel/assets/advanced-datatable/media/js/jquery.dataTables.js'></script>   ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/data-tables/DT_bootstrap.js'></script>                                              ");
            sb.Append("<!--dynamic table initialization -->                                                                                                             ");
            sb.Append("<script src='../../Scripts/UserPanel/js/dynamic_table/dynamic_table_init.js'></script>                                                                 ");
            return sb.ToString();
        }

        public static String GetDynamicTableScript()
        {
            return SetDynamicTableScript();
        }

        private static String SetInitialisationScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/scripts.js'></script>");
            sb.Append(" <script src='../../Scripts/chosen/chosen.jquery.js' type='text/javascript'></script>");
            sb.Append(" <script type='text/javascript'>                                                     ");
            sb.Append(" $('.chosen').chosen();                                                              ");
            sb.Append(" $('.chosen').chosen({ no_results_text: 'Oops, nothing found!' });                   ");
            sb.Append(" </script>                                                                           ");
            return sb.ToString();
        }

        public static String GetInitialisationScript()
        {
            return SetInitialisationScript();
        }

        private static String SetCustomFormScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/assets/bootstrap-switch-master/build/js/bootstrap-switch.js'></script>                            ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/fuelux/js/spinner.min.js'></script>                                 ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-fileupload/bootstrap-fileupload.js'></script>             ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-wysihtml5/wysihtml5-0.3.0.js'></script>                   ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.js'></script>               ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-datepicker/js/bootstrap-datepicker.js'></script>          ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js'></script>  ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-daterangepicker/moment.min.js'></script>                  ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-daterangepicker/daterangepicker.js'></script>             ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js'></script>        ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-timepicker/js/bootstrap-timepicker.js'></script>          ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/jquery-multi-select/js/jquery.multi-select.js'></script>            ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/jquery-multi-select/js/jquery.quicksearch.js'></script>             ");
            //sb.Append("<script src='../../Scripts/UserPanel/js/toggle-button/toggle-init.js'></script>                                                        ");
            sb.Append("<script src='../../Scripts/UserPanel/js/advanced-form/advanced-form.js'></script>                                                      ");
            sb.Append("<script type='text/javascript' src='../../Scripts/UserPanel/assets/bootstrap-inputmask/bootstrap-inputmask.min.js'></script>           ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/jquery-tags-input/jquery.tagsinput.js'></script>											");
            return sb.ToString();
        }

        public static String GetCustomFormScript()
        {
            return SetCustomFormScript();
        }

        private static String SetPieChartScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<!--Easy Pie Chart-->                                                                    ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/easypiechart/jquery.easypiechart.js'></script>     ");
            return sb.ToString();
        }

        public static String GetPieChartScript()
        {
            return SetSparklineChartScript();
        }

        private static String SetSparklineChartScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<!--Sparkline Chart-->                                                                   ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/sparkline/jquery.sparkline.js'></script>           ");
            return sb.ToString();
        }

        public static String GetSparklineChartScript()
        {
            return SetSparklineChartScript();
        }

        private static String SetFlotChartScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<!--jQuery Flot Chart-->                                                                 ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/flot-chart/jquery.flot.js'></script>               ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/flot-chart/jquery.flot.tooltip.min.js'></script>   ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/flot-chart/jquery.flot.resize.js'></script>        ");
            sb.Append("<script src='../../Scripts/UserPanel/assets/flot-chart/jquery.flot.pie.resize.js'></script>	");
            return sb.ToString();
        }

        public static String GetFlotChartScript()
        {
            return SetFlotChartScript();
        }

        private static String SetGritterScript()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/gritter/gritter.js' type='text/javascript'></script>   ");
            return sb.ToString();
        }

        public static String GetGritterScript()
        {
            return SetGritterScript();
        }

        private static String SetCustomTreeViewScripts()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/lib/jquery.js'></script>");
            sb.Append("<script src='../../Scripts/UserPanel/bs3/js/bootstrap.min.js'></script>");
            sb.Append("<script class='include' type='text/javascript' src='../../Scripts/UserPanel/js/accordion-menu/jquery.dcjqaccordion.2.7.js'></script>");
            sb.Append("<script src='../../Scripts/UserPanel/js/scrollTo/jquery.scrollTo.min.js'></script>");
            sb.Append("<script src='../../Scripts/UserPanel/js/nicescroll/jquery.nicescroll.js' type='text/javascript'></script>");
            return sb.ToString();
        }

        public static String GetCustomTreeViewScript()
        {
            return SetCustomTreeViewScripts();
        }

        private static String SetTreeViewScripts()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/assets/fuelux/js/tree.min.js'</script>   ");
            return sb.ToString();
        }

        public static String GetTreeViewScript()
        {
            return SetTreeViewScripts();
        }

        private static String SetTreeViewInitScripts()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/tree/tree.js'></script>");
            sb.Append("<script> jQuery(document).ready(function() { TreeView.init(); }); </script>");
            return sb.ToString();
        }

        public static String GetTreeViewInitScript()
        {
            return SetTreeViewInitScripts();
        }

        private static String SetNestableScripts()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/assets/nestable/jquery.nestable.js'></script>");
            return sb.ToString();
        }

        public static String GetNestableScript()
        {
            return SetNestableScripts();
        }

        private static String SetNestableInitScripts()
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<script src='../../Scripts/UserPanel/js/nestable/nestable.js'></script>");
            return sb.ToString();
        }

        public static String GetNestableInitScript()
        {
            return SetNestableInitScripts();
        }

        private static String SetCharacterValidationScripts()
        {
            StringBuilder sb = new StringBuilder();

            sb.Append(@" <script lang='javascript' type='text/javascript'> ");
            sb.Append(@" function CheckNumeric(e) {                        ");
            sb.Append(@" if (window.event)                                 ");    
            sb.Append(@" {                                                 ");
            sb.Append(@" if ((e.keyCode < 48 || e.keyCode > 57)            ");
            sb.Append(@" & e.keyCode != 8) {                               ");
            sb.Append(@" event.returnValue = false;                        ");
            sb.Append(@" return false;                                     ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");
            sb.Append(@" else {                                            ");  
            sb.Append(@" if ((e.which < 48 || e.which > 57)                ");
            sb.Append(@" & e.which != 8) {                                 ");
            sb.Append(@" e.preventDefault();                               ");
            sb.Append(@" return false;                                     ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");   
            sb.Append(@" function CheckAlphabet(e)                         ");   
            sb.Append(@" {                                                 ");   
            sb.Append(@" if (window.event)                                 ");   
            sb.Append(@" {                                                 ");   
            sb.Append(@" if (((e.keyCode < 65 || e.keyCode > 90) &&        "); 
            sb.Append(@" (e.keyCode < 97 || e.keyCode > 122)) &&           ");
            sb.Append(@" e.keyCode != 8 && e.keyCode != 32)                ");
            sb.Append(@" {                                                 ");   
            sb.Append(@" event.returnValue = false;                        ");   
            sb.Append(@" return false;                                     ");       
            sb.Append(@" }                                                 ");   
            sb.Append(@" }                                                 ");   
            sb.Append(@" else                                              ");   
            sb.Append(@" {                                                 ");    
            sb.Append(@" if (((e.which < 65 || e.which > 90) &&            "); 
            sb.Append(@" (e.which < 97 || e.which > 122)) &&               ");
            sb.Append(@" e.which != 8 && e.which != 32)                    ");
            sb.Append(@" {                                                 ");      
            sb.Append(@" e.preventDefault();                               ");   
            sb.Append(@" return false;                                     ");   
            sb.Append(@" }                                                 ");   
            sb.Append(@" }                                                 ");   
            sb.Append(@" }                                                 ");  
            sb.Append(@" function CheckAlphaNumeric(e) {                   ");
            sb.Append(@" if (window.event)                                 ");   
            sb.Append(@" {                                                 ");
            sb.Append(@" if (((e.keyCode < 63 || e.keyCode > 90) &&        ");
            sb.Append(@" (e.keyCode < 97 || e.keyCode > 125) &&            ");
            sb.Append(@" (e.which < 40 || e.which > 57))                   ");
            sb.Append(@" && e.keyCode != 8 && e.keyCode != 32              ");
            sb.Append(@" && e.keyCode != 33) {                             ");
            sb.Append(@" event.returnValue = false;                        ");
            sb.Append(@" return false;                                     ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");
            sb.Append(@" else {                                            "); 
            sb.Append(@" if (((e.which < 63 || e.which > 90) &&            ");
            sb.Append(@" (e.which < 97 || e.which > 125) &&                ");
            sb.Append(@" (e.which < 40 || e.which > 57))                   ");
            sb.Append(@" && e.which != 8 && e.which != 32                  ");
            sb.Append(@" && e.which != 33) {                               ");
            sb.Append(@" e.preventDefault();                               ");
            sb.Append(@" return false;                                     ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");
            sb.Append(@" }                                                 ");
            sb.Append(@" </script>                                         ");

            return sb.ToString();
        }

        public static String GetCharacterValidationInitScript()
        {
            return SetCharacterValidationScripts();
        }
    }

    public class InitJavascript
    {
        public static String InitializeCalendar(List<object[]> data)
        {
            StringBuilder script = new StringBuilder();
            script.Append(" var Script = function () {                                          ");
            script.Append(" $('#external-events div.external-event').each(function() {          ");
            script.Append(" var eventObject = {                                                 ");
            script.Append(" title: $.trim($(this).text())                                       ");
            script.Append(" };                                                                  ");
            script.Append(" $(this).data('eventObject', eventObject);                           ");
            script.Append(" $(this).draggable({                                                 ");
            script.Append(" zIndex: 999,                                                        ");
            script.Append(" revert: true,                                                       ");
            script.Append(" revertDuration: 0                                                   ");
            script.Append(" });                                                                 ");
            script.Append(" });                                                                 ");
            //variable initialization
            script.Append(" var date = new Date();                                              ");
            script.Append(" var d = date.getDate();                                             ");
            script.Append(" var m = date.getMonth();                                            ");
            script.Append(" var y = date.getFullYear();                                         ");
            
            script.Append(" $('#calendar').fullCalendar({                                       ");
            script.Append(" header: {                                                           ");
            script.Append(" left: 'prev,next today',                                            ");
            script.Append(" center: 'title',                                                    ");
            script.Append(" right: 'month,basicWeek,basicDay'                                   ");
            script.Append(" },                                                                  ");
            script.Append(" editable: true,                                                     ");
            script.Append(" droppable: true,                                                    ");
            script.Append(" drop: function(date, allDay) {                                      ");
            script.Append(" var originalEventObject = $(this).data('eventObject');              ");
            script.Append(" var copiedEventObject = $.extend({}, originalEventObject);          ");
            script.Append(" copiedEventObject.start = date;                                     ");
            script.Append(" copiedEventObject.allDay = allDay;                                  ");
            script.Append(" $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);");
            script.Append(" if ($('#drop-remove').is(':checked')) {                             ");
            script.Append(" $(this).remove();                                                   ");
            script.Append(" }                                                                   ");
            script.Append(" },                                                                  ");
            
            //data serialize
            script.Append(" events: [                                                           ");
            script.Append(" {                                                                   ");
            script.Append(" title: 'Jadwal 5',                                                  ");
            script.Append(" start: new Date(y, m, 1),                                           ");
            script.Append(" url: '../../Views/Application/Dashboard.aspx'                        ");
            script.Append(" },                                                                  ");
            script.Append(" {                                                                   ");
            script.Append(" title: 'Jadwal 2',                                                  ");
            script.Append(" start: new Date(y, m, d-5),                                         ");
            script.Append(" end: new Date(y, m, d-2),                                           ");
            script.Append(" url: '../../Views/Application/Dashboard.aspx'                        ");
            script.Append(" },                                                                  ");
            script.Append(" {                                                                   ");
            script.Append(" title: 'Jadwal 3',                                                  ");
            script.Append(" start: new Date(y, m, 28),                                          ");
            script.Append(" end: new Date(y, m, 29),                                            ");
            script.Append(" url: '../../Views/Application/Dashboard.aspx'                        ");
            script.Append(" }                                                                   ");
            script.Append(" ]                                                                   ");
            script.Append(" });                                                                 ");
            script.Append(" }();                                                                ");

            return script.ToString();
        }
    }
}
