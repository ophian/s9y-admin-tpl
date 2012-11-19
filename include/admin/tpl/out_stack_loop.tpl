{* serendipity_plugins_admin.inc.php::serendipity_plugin_config() - the OUT_STACK loop *}
    {if $ctype == 'seperator'}
        <tr>
            <td colspan="2"><hr></td>
        </tr>
    {/if}
    {if $ctype == 'select'}
        <tr>
            <td><strong>{$cname}</strong>
        {if $cdesc != ''}
                <span>{$cdesc}</span>
        {/if}
            </td>
            <td width="250">
                <select class="direction_{$lang_direction}" name="serendipity[{$postKey}][{$config_item}]{($is_multi_select) ? '[]' : ''}" {($is_multi_select) ? 'multiple="multiple"' : ''} {($is_multi_select && ($select_size > 0)) ? "size='{$select_size}'" : ''}>
                {foreach $select AS $select_value => $select_desc}
                    {assign var="id" value="{$config_item|escape}_{$select_value|escape}"}
                    <!-- case select assign id={$id} -->
                    <option value="{$select_value}" {(in_array($select_value, $selected_options) || in_array($select_value, $pre_selected)) ? 'selected="selected"' : ''} title="{$select_desc|escape}">{$select_desc|escape}</option>
                {/foreach}
                </select>
            </td>
        </tr>
    {/if}
    {if $ctype == 'radio'}
        <tr>
            <td><strong>{$cname}</strong>
        {if $cdesc != ''}
                <span>{$cdesc}</span>
        {/if}
            </td>
            <td width="250">
            {foreach $radio_button AS $r}
                {if $r['counter'] == 1}
                <div class="clearfix">
                {/if}
                    <input id="serendipity_plugin_{$r['id']}" class="direction_{$lang_direction} input_radio" name="serendipity[{$postKey}][{$config_item}]" type="radio" value="{$r['value']}" {(!empty($r['checked'])) ? 'checked="checked"' : ''} title="{$r['index']|escape}" />
                    <label for="serendipity_plugin_{$r['id']}">{$r['index']}{* escapement is already done *}</label>
                {if ($r['counter'] == $per_row)}
                    {assign var="r" value="counter[0]"}
                </div>
                {/if}
            {/foreach}
            </td>
        </tr>
    {/if}
    {if $ctype == 'string'}
        <tr>
            <td><strong>{$cname}</strong>
                <span>{$cdesc}</span>
            </td>
            <td width="250">
                <div>
                    <input class="direction_{$lang_direction} input_textbox" name="serendipity[{$postKey}][{$config_item}]" type="{$input_type}" value="{$hvalue}">
                </div>
            </td>
        </tr>
    {/if}
    {if (($ctype == 'html') || ($ctype == 'text'))}
        <tr>
            <td colspan="2"><strong>{$cname}</strong>
                <span>{$cdesc}</span>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <div>
                    <textarea id="nuggets{$elcount}" class="direction_{$lang_direction}" name="serendipity[{$postKey}][{$config_item}]" rows="{$text_rows}">{$hvalue}</textarea>
                </div>
            </td>
        </tr>
    {/if}
    {if $ctype == 'content'}
        <tr>
            <td colspan="2">{$cbag_default}</td>
        </tr>
    {/if}
    {if $ctype == 'custom'}
        <tr>
            <td colspan="2">
                <input id="config_{$postKey}_{$config_item}" name="serendipity[{$postKey}][{$config_item}]" type="hidden" value="{$hvalue}">
                {$cbag_custom}
            </td>
        </tr>
    {/if}
    {if $ctype == 'hidden'}
        <tr>
            <td colspan="2">
                <input class="direction_{$lang_direction}" name="serendipity[{$postKey}][{$config_item}]" type="hidden" value="{$cbag_value}">
            </td>
        </tr>
    {/if}
    {if $ctype == 'media'}
        {if !$mediajs_output}
        <script type="text/javascript" src="serendipity_editor.js"></script>
        <script type="text/javascript" src="{serendipity_getFile file='admin/image_selector.js'}"></script>
        {/if}
        <tr>
            <td colspan="2"><strong>{$cname}</strong>
                <span>{$cdesc}</span>
            </td>
        </tr>
        <tr>
            <td>
                <div id="{$config_item}_preview" style="background-image: url({$value}); width: {$preview_width}; height: {$preview_height}; background-repeat: no-repeat;">&nbsp;</div>
            </td>
            <td>
                <input id="serendipity[{$postKey}][{$config_item}]" class="input_textbox" name="serendipity[{$postKey}][{$config_item}]" type="text" value="{$value}" onchange="change_preview('{$config_item}')">
                <a href="#" onclick="choose_media('serendipity[{$postKey}][{$config_item}]')">{$CONST.MEDIA_LIBRARY}</a>
            </td>
        </tr>
    {/if}
    {if $ctype == 'sequence'}
        {if !$sequencejs_output}
        <script src="{serendipity_getFile file='dragdrop.js'}" type="text/javascript"></script>
        {/if}
        <tr>
            <td><strong>{$cname}</strong>
                <span>{$cdesc}</span>
            </td>
            <td>
                <input id="{$config_item}_value" name="serendipity[{$postKey}][{$config_item}]" type="hidden" value="{$value}">
                <noscript>
                    <!-- Replace standard submit button when using up/down submits -->
                    <input type="hidden" name="SAVECONF" value="Save">
                </noscript>
                <ol id="{$config_item}" class="sequence_container pluginmanager_container">
                {foreach $order_id as $orid}
                    <li id="{$orid['id']}" class="sequence_item pluginmanager_item_even">
                        <div id="g{$orid['id']}" class="pluginmanager_grablet sequence_grablet"><a href="#"></a></div>
                    {if $checkable}
                        <input id="activate_{$orid['id']}" name="serendipity[{$postKey}][activate][{$config_item}][{$orid['id']}]" {(in_array($orid['id'], $store_order)) ? ' checked="checked" ' : ''} type="checkbox" onclick="sort_{$config_item}_Sequence();" value="true">
                    {/if}
                        <span>{$items[{$orid['id']}]['display']}</span>
                    {if isset($items[{$orid['id']}]['img'])}
                        <img src="{$items[{$orid['id']}]['img']}">
                    {/if}
                        <noscript>
                            <div>
                        {if ($orid['sort_idx'] == 0)}
                            &nbsp;
                        {else}
                            <button id="{$postKey}_{$config_item}_{$orid['sort_idx']}_up" name="serendipity[{$postKey}][override][{$config_item}]" type="submit" value="{$orid['oneup']}"><img src="{serendipity_getFile file='admin/img/uparrow.png'}" alt="Move Up"></button>
                        {/if}
                        {if ($orid['sort_idx'] == $last)}
                            &nbsp;
                        {else}
                            <button id="{$postKey}_{$config_item}_{$orid['sort_idx']}_down" name="serendipity[{$postKey}][override][{$config_item}]" type="submit" value="{$orid['onedown']}"><img src="{serendipity_getFile file='admin/img/downarrow.png'}" alt="Move Down"></button>
                        {/if}
                            </div>
                        </noscript>
                    </li>
                {/foreach}
                </ol>
                {if (!is_array($items) || empty($order_id))}
                    {$none}
                {/if}
{*
Smarty 3 has a new auto literal option which is enabled by default.
When the { is followed by a space it's not interpreted as smarty delimiter but literal.
*}
                <script type="text/javascript">
                    function sort_{$config_item}_Sequence() {
                        //var seq = DragDrop.serData('{$config_item}_group', null);
                        var seq = DragDrop.serData(null, '+citem+');
                        var start = seq.indexOf("(");
                        var end = seq.indexOf(")");
                        seq = seq.slice((start + 1), end);
                        checkable_seq = seq.split(",");
                        out_seq = '';
                        for (i in checkable_seq) {
                            if (document.getElementById('activate_' + checkable_seq[i]) && !document.getElementById('activate_' + checkable_seq[i]).checked) {
                                continue;
                            } else {
                                if (out_seq != '') {
                                    out_seq += ',';
                                }
                            out_seq += checkable_seq[i];
                            }
                        }
                        var order = document.getElementById("{$config_item}_value");
                        order.value = out_seq;
                    }

                    function init_{$config_item}_Sequence() {
                        var lst = document.getElementById("{$config_item}");
                        DragDrop.makeListContainer(lst, '{$config_item}_group');
                        lst.onDragOut = function() {
                            sort_{$config_item}_Sequence();
                        };
                    }
                    addLoadEvent(init_{$config_item}_Sequence);
                </script>
            </td>
    {/if}
