{* HTML5: Yes *}
{* jQuery: NN *}

{if $delete_yes}
    {if $no_delete_permission}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED}</span>
    {else}
        {if $no_delete_permission_userlevel}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED_USERLEVEL}</span>
        {else}
            {if $delete_permission}
            <span class="msg_success">{$CONST.DELETED_USER|sprintf:"{$user|escape:"html"}":"{$realname|escape:"html"}"}</span>
            {else}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED_USERLEVEL}</span>
            {/if}
        {/if}
    {/if}
{/if}
{if $save_new}
    {if $no_save_permission}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED}</span>
    {else}
        {if $no_group_selected}
            <span class="msg_error">{$CONST.WARNING_NO_GROUPS_SELECTED}</span>
        {/if}
            <span class="msg_success">{$CONST.CREATED_USER|sprintf:"# {$user|escape:"html"}":"{$realname|escape:"html"}"}</span>
    {/if}
{/if}
{if $save_edit}
    {if $no_edit_permission}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED}</span>
    {else}
        {if $no_edit_permission_userlevel}
            <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED_USERLEVEL}</span>
        {else}
            {if $no_group_selected}
            <span class="msg_error">{$CONST.WARNING_NO_GROUPS_SELECTED}</span>
            {/if}
            <span class="msg_success">{$CONST.MODIFIED_USER|sprintf:"{$realname|escape:"html"}"}</span>
        {/if}
    {/if}
{/if}
{if $delete == false}
    <h2>{$CONST.USER} ({$CONST.USER_LEVEL})</h2>

    <ul class="plainList">
    {foreach $users as $user}
        {if $user.isEditable}
        <li><span class="{if $user.userlevel >= {$CONST.USERLEVEL_ADMIN}}user_admin{else}{if $user.userlevel >= {$CONST.USERLEVEL_CHIEF}}user_chief{else}user_editor{/if}{/if}">{$user.realname|escape:"html"} ({$user.userlevel})</span>
            <a class="link_view" href="{$user.authorUrl}" title="{$CONST.PREVIEW} {$user.realname}">{$CONST.PREVIEW}</a>
            <a class="link_edit" href="?serendipity[adminModule]=users&amp;serendipity[adminAction]=edit&amp;serendipity[userid]={$user.authorid}#editform" title="{$CONST.EDIT} {$user.realname|escape:"html"}">{$CONST.EDIT}</a>
            <a class="link_delete" href="?{$urlFormToken}&amp;serendipity[adminModule]=users&amp;serendipity[adminAction]=delete&amp;serendipity[userid]=$user.authorid" title="{$CONST.DELETE} {$user.realname|escape:"html"}">{$CONST.DELETE}</a>
        </li>
        {/if}
    {/foreach}
    </ul>
    {if $new}
    <form action="?serendipity[adminModule]=users" method="post">
        <input name="NEW" type="submit" value="{$CONST.CREATE_NEW_USER}">
    </form>
    {/if}
{/if}
{if $show_form}
    <form{if $adminAction == 'edit'} id="editform"{/if} action="?serendipity[adminModule]=users#editform" method="post">
        {$formToken}
        {if $adminAction == 'edit'}{if $create_permission}<input name="serendipity[user]" type="hidden" value="{$from.authorid}">{/if}{/if}
        <h3>{if $adminAction == 'edit'}{if $no_create_permission}{$CONST.CREATE_NOT_AUTHORIZED}: {$CONST.EDIT}{else}{if $create_permission}{$CONST.EDIT}{else}{$CONST.CREATE_NOT_AUTHORIZED}: {$CONST.EDIT}{/if}{/if}{else}{$CONST.CREATE}{/if}</h3>
        {$config}
    {if $adminAction == 'edit'}
        <input name="SAVE_EDIT" type="submit" value="{$CONST.SAVE}">
    {else}
        <input name="SAVE_NEW" type="submit" value="{$CONST.CREATE_NEW_USER}">
    {/if}
    </form>
{else}
    {if $delete}
    <form action="?serendipity[adminModule]=users" method="post">
        {$formToken}
        <input name="serendipity[user]" type="hidden" value="{$userid}">
        <fieldset class="users_delete_action">
            <legend>{$CONST.DELETE_USER|sprintf:"{$userid}":"{$realname|escape:"html"}"}</legend>
            <input name="DELETE_YES" type="submit" value="{$CONST.DUMP_IT}">
            <input name="NO" type="submit" value="{$CONST.NOT_REALLY}">
        </fieldset>
    </form>
    {/if}
{/if}
