{* serendipity_plugins_admin.inc.php::serendipity_plugin_config() *}

<script type="text/javascript">
    var const_view = '{$CONST.VIEW_FULL}';
    var const_hide = '{$CONST.HIDE}';
    var img_plus   = '{serendipity_getFile file="img/plus.png"}';
    var img_minus  = '{serendipity_getFile file="img/minus.png"}';
</script>

{if $allow_admin_scripts}
<script type="text/javascript" src="{serendipity_getFile file='admin/admin_scripts.js'}"></script>
{/if}
{if $showSubmit_head}
    <div class="save_conf">
        <input class="serendipityPrettyButton input_button" name="SAVECONF" type="submit" value="{$CONST.SAVE}">
    </div>
{/if}
{if $showTable}
    <table id="serendipity_plugin_config" border="0" cellspacing="0" cellpadding="3" width="100%">
{/if}
{if is_array($config_groups)}
        <tr>
            <td colspan="2">
                <a href="#" onClick="showConfigAll({sizeof($config_groups)}); return false" title="{$CONST.TOGGLE_ALL}"><img id="optionall" src="{serendipity_getFile file="img/plus.png"}" alt="+/-">{$CONST.TOGGLE_ALL}</a>
            </td>
        </tr>
        {foreach $config_groups AS $config_header => $config_groupkeys}
        <tr>
            <td colspan="2">
                <h2><a href="#" onClick="showConfig('el{$config_groupkeys@iteration}'); return false" title="{$CONST.TOGGLE_OPTION}"><img id="optionel{$config_groupkeys@iteration}" src="{serendipity_getFile file="img/plus.png"}" alt="+/-">{$config_header}</a></h2>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table id="el{$config_groupkeys@iteration}" class="plugin_optiongroup" cellspacing="0" cellpadding="3" width="100%">
                {foreach $config_groupkeys AS $config_groupkey}
                    {$OUT_STACK[$config_groupkey]}
                {/foreach}
                </table>
                <script type="text/javascript">
                    document.getElementById('el{$config_groupkeys@iteration}').style.display = "none";
                </script>
            </td>
        </tr>
        {/foreach}
        <tr><td id="configuration_footer" colspan="2" style="height: 100px">&nbsp;</td></tr>
{/if} {* foreach config_groups end *}

{foreach $OUT_STACK_REST as $out_stack_config_item}
    {$out_stack_config_item}
{/foreach}

{if $showTable}
    </table>
{/if}
{* $serendipity_printConfigJS *}{* outsourced to templates/default/admin/admin_scripts.js - see passed vars on top *}
{if $showSubmit_foot}
    <div class="save_conf">
        <input class="serendipityPrettyButton input_button" type="submit" name="SAVECONF" value="{$CONST.SAVE}">
    </div>
{/if}
{if $showExample}
    <div>{$plugin_example}</div>
{/if}
{if $spawnNuggets}
    {serendipity_hookPlugin hook="backend_wysiwyg_nuggets" eventData=$ev hookAll=true}
    {if ($ev['skip_nuggets'] === false)}
    <script type="text/javascript">
    function Spawnnugget() { 
        {foreach $htmlnugget AS $htmlnuggetid}
        Spawnnuggets('{$htmlnuggetid}');
        {/foreach}
    } 
    </script>
    {/if}
{/if}
