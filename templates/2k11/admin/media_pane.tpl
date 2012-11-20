{* HTML5: No  *}
{* jQuery: No *}

<script type="text/javascript" src="{serendipity_getFile file='admin/admin_scripts.js'}"></script>

<h2>{$CONST.FIND_MEDIA}</h2>

<form method="get" action="?">
    {$media.token}
    {$media.form_hidden}
    <fieldset>
        <legend><span>{$CONST.FILTERS}</span></legend>

        <a href="#" onclick="showFilters(); return false">{$CONST.FILTERS}</a>

        <div id="media_filter" class="clearfix">
            <div id="media_filter_path" class="form_select">
                <label for="">{$CONST.FILTER_DIRECTORY}</label>
                <select name="serendipity[only_path]">
                    <option value="">{if NOT $media.limit_path}{$CONST.ALL_DIRECTORIES}{else}{$media.blimit_path}{/if}</option>
                {foreach from=$media.paths item="folder"}
                    <option {if ($media.only_path == $media.limit_path|cat:$folder.relpath)}selected="selected"{/if} value="{$folder.relpath}">{'&nbsp;'|str_repeat:$folder.depth*2}{$folder.name}</option>
                {/foreach}
                </select>
            </div>

            <div id="media_filter_file" class="form_field">
                <label for="">{$CONST.SORT_ORDER_NAME}</label>
                <input name="serendipity[only_filename]" type="text" value="{$media.only_filename|@escape}">
            </div>
        </div>

        <div id="moreFilter" class="serendipity_pluginlist_section" style="height: auto; display: none">
            <div class="form_field">
                <label for="keyword_input">{$CONST.MEDIA_KEYWORDS}</label>
                <input id="keyword_input" name="serendipity[keywords]" type="text" value="{$media.keywords_selected|@escape}">
            </div>
            <div id="keyword_list" class="clearfix">
            {foreach from=$media.keywords item="keyword"}
                <a href="#" onclick="AddKeyword('{$keyword|@escape}'); return false">{$keyword|@escape}</a>
            {/foreach}
            </div>

        {foreach from=$media.sort_order item="so_val" key="so_key"}
            <div class="form_field">
                <label for="">{$so_val.desc}</label>
            {if $so_val.type == 'date'}
                {if $media.filter[$so_key].from != '' OR $media.filter[$so_key].to != ''}{assign var="show_filter" value=$media.filter[$so_key]}{/if}
                <input name="serendipity[filter][{$so_key}][from]" type="text" value="{$media.filter[$so_key].from|@escape}">
                 - <input name="serendipity[filter][{$so_key}][to]" type="text" value="{$media.filter[$so_key].to|@escape}">
                <span class="input_hint">(DD.MM.YYYY | YYYY-MM-DD | MM/DD/YYYY)</span>
            {elseif $so_val.type == 'intrange'}
                {if $media.filter[$so_key].from != '' OR $media.filter[$so_key].to != ''}{assign var="show_filter" value=$media.filter[$so_key]}{/if}
                <input name="serendipity[filter][{$so_key}][from]" type="text" value="{$media.filter[$so_key].from|@escape}">
                 - <input name="serendipity[filter][{$so_key}][to]" type="text" value="{$media.filter[$so_key].to|@escape}">
            {elseif $so_val.type == 'authors'}
                {if $media.filter[$so_key] != ''}{assign var="show_filter" value=$media.filter[$so_key]}{/if}
                <select name="serendipity[filter][{$so_key}]">
                    <option value="">{$CONST.ALL_AUTHORS}</option>
                {foreach from=$media.authors item="media_author"}
                    <option value="{$media_author.authorid}" {if $media.filter[$so_key] == $media_author.authorid}selected="selected"{/if}>{$media_author.realname|@escape}</option>
                {/foreach}
                </select>
            {else}
                {if $media.filter[$so_key] != ''}{assign var="show_filter" value=$media.filter[$so_key]}{/if}
                    <input name="serendipity[filter][{$so_key}]" type="text" value="{$media.filter[$so_key]|@escape}">
            {/if}
            </div>
        {/foreach}
        </div>
    </fieldset>
{if $media.keywords_selected != '' OR $show_filter}
    <script type="text/javascript">showFilters();</script>
{/if}
    <fieldset>
        <legend><span>{$CONST.SORT_ORDER}</span></legend>

        <div class="form_select">
            <label for="">{$CONST.SORT_BY}</label>

            <select name="serendipity[sortorder][order]">
            {foreach from=$media.sort_order item="so_val" key="so_key"}
                <option value="{$so_key}" {if $media.sortorder.order == $so_key}selected="selected"{/if}>{$so_val.desc}</option>
            {/foreach}
            </select>
        </div>

        <div class="form_select">
            <label for="">{$CONST.SORT_ORDER}</label>
            
            <select name="serendipity[sortorder][ordermode]">
                <option value="DESC" {if $media.sortorder.ordermode == 'DESC'}selected="selected"{/if}>{$CONST.SORT_ORDER_DESC}</option>
                <option value="ASC"  {if $media.sortorder.ordermode == 'ASC'}selected="selected"{/if}>{$CONST.SORT_ORDER_ASC}</option>
            </select>
        </div>

        <div class="form_select">
            <label for="">{$CONST.FILES_PER_PAGE}</label>

            <select name="serendipity[sortorder][perpage]">
            {foreach from=$media.sort_row_interval item="so_val"}
                <option value="{$so_val}" {if $media.perPage == $so_val}selected="selected"{/if}>{$so_val}</option>
            {/foreach}
            </select>
        </div>
    </fieldset>
{if $media.show_upload}
    <input type="button" value="{$CONST.ADD_MEDIA|@escape}" onclick="location.href='{$media.url}&amp;serendipity[adminAction]=addSelect&amp;serendipity[only_path]={$media.only_path|escape:url}'; return false">
{/if}
    <input name="go" type="submit" value="{$CONST.GO}">
</form>
{if $media.nr_files < 1}
    <span class="msg_notice">{$CONST.NO_IMAGES_FOUND}</span>
{else}
{if $smarty.get.serendipity.adminModule == 'media'}
<form id="formMultiDelete" name="formMultiDelete" action="?" method="post">
    {$media.token}
    <input name="serendipity[action]" type="hidden" value="admin">
    <input name="serendipity[adminModule]" type="hidden" value="media">
    <input name="serendipity[adminAction]" type="hidden" value="multidelete">
{/if}
<table border="0" width="100%">
    <tr>
        <td colspan="{$media.lineBreak}">
            <table width="100%">
                <tr>
                    <td>
                    {if $media.page != 1 AND $media.page <= $media.pages}
                        <a href="{$media.linkPrevious}">{$CONST.PREVIOUS}</a>
                    {/if}
                    </td>
                    <td align="right">
                    {if $media.page != $media.pages}
                        <a href="{$media.linkNext}">{$CONST.NEXT}</a>
                    {/if}
                    </td>
                </tr>
            </table>
        </td>
    </tr>

    <tr>
    {$MEDIA_ITEMS}
    </tr>

    <tr>
        <td colspan="{$media.lineBreak}">
            <table width="100%">
                <tr>
                    <td>
                    {if $media.page != 1 AND $media.page <= $media.pages}
                        <a href="{$media.linkPrevious}">>{$CONST.PREVIOUS}</a>
                    {/if}
                    </td>
                    <td align="right">
                    {if $media.page != $media.pages}
                        <a href="{$media.linkNext}">{$CONST.NEXT}</a>
                    {/if}
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

{if $smarty.get.serendipity.adminModule == 'media'}
<div class="button_block">
    <input name="toggle" type="button" value="{$CONST.INVERT_SELECTIONS}" onclick="invertSelection()">
    <input name="toggle" type="submit" value="{$CONST.DELETE_SELECTED_ENTRIES}">
</div>

</form>
{/if}

{/if}
