{* HTML5: Yes *}
{* jQuery: NN *}
{if $delete_yes}
    <span class="msg_success">{$CONST.DELETED_GROUP|sprintf:"{$group_id|escape:"html"}":"{$group.name|escape:"html"}"}</span>
{/if}
{if $save_new}
    <span class="msg_success">{$CONST.CREATED_GROUP|sprintf:"{$group_id|escape:"html"}":"{$group.name|escape:"html"}"}</span>
{/if}
{if $save_edit}
    <span class="msg_success">{$CONST.MODIFIED_GROUP|sprintf:"{$name|escape:"html"}"}</span>
{/if}

{if $delete == false}
    <h2>{$CONST.GROUP}</h2>

    <ul id="serendipity_groups" class="plainList">
    {foreach $groups as $group}
        <li><span>{$group.name|escape:"html"}</span>
            <a class="link_edit" href="?serendipity[adminModule]=groups&amp;serendipity[adminAction]=edit&amp;serendipity[group]={$group.id}" title="{$CONST.EDIT} {$group.name|escape:"html"}">{$CONST.EDIT}</a>
            {* BUG: Doesn't skip to the deletion process *}
            <a class="link_delete" href="?{$deleteFormToken}&amp;serendipity[adminModule]=groups&amp;serendipity[adminAction]=delete&amp;serendipity[group]={$group.id}" title="{$CONST.DELETE} {$group.name|escape:"html"}">{$CONST.DELETE}</a></li>
    {/foreach}
    </ul>
    {if ! $new}
    <form action="?serendipity[adminModule]=groups" method="post">
        <input type="submit" name="NEW" value="{$CONST.CREATE_NEW_GROUP}">
    </form>
    {/if}
{/if}

{if $edit || $new}
    <form action="?serendipity[adminModule]=groups" method="post">
        {$formToken}
    {if $edit}
        <h2>{$CONST.EDIT}</h2>
        <input type="hidden" name="serendipity[group]" value="{$from.id}">
    {else}
        <h2>{$CONST.CREATE}</h2>
    {/if}
        <div class="form_field">
            <label for="group_name">{$CONST.NAME}</label>
            {* BUG: Doesn't correctly pull the group name *}
            <input id="group_name" type="text" name="serendipity[name]" value="{$from.name|escape:"html"}">
        </div>

        <div class="form_select">
            <label for="group_members">{$CONST.USERCONF_GROUPS}</label>
            <select id="group_members" name="serendipity[members][]" multiple="multiple" size="5">
                {foreach $allusers as $user}
                <option value="{$user.authorid}" {if isset($selected.{$user.authorid})} selected="selected"{/if} >{$user.realname|escape:"html"}</option>
                {/foreach}
            </select>
        </div>
        {foreach $perms as $perm}
        {* TODO: major rewrite *}
            {if {{$perm@key}|truncate:"2":""} == "f_"}
                {continue}
            {/if}
            {if ! isset($section)}
                {$section=$perm@key}
            {/if}
            {if $section != {$perm@key} && {{$perm@key}|truncate:"{$section|count_characters}":""} == $section}
                {$indent="&nbsp;&nbsp;"}
            {else}
                {if $section != {$perm@key}}
                    {$indent="<br />"}
                    {$section="{$perm@key}"}
                {/if}
            {/if}
            {if $perm.permission == false}
                <div>
                    <span class="perm_name">{$indent} {$perm.permission_name|escape:"html"}</span>
                    <span class="perm_status">{if isset($from.{$perm@key}) && $from.{$perm@key} == "true"}YES{else}NO{/if}</span>
                </div>
            {else}
                <div class="form_check">
                    {$indent} <label for="{{$perm@key}|escape:"html"}">{$perm.permission_name|escape:"html"}</label>
                    <input id="{{$perm@key}|escape:"html"}" type="checkbox" name="serendipity[{{$perm@key}|escape:"html"}]" value="true"{if isset({$from.{$perm@key}}) && {$from.{$perm@key}} == "true"} checked="checked"{/if}>
                </div>
            {/if}
        {/foreach}
        {if $enablePluginACL}
            <div class="form_select">
                <label for="forbidden_plugins">{$CONST.PERMISSION_FORBIDDEN_PLUGINS}</label>
                <select id="forbidden_plugins" name="serendipity[forbidden_plugins][]" multiple="multiple" size="5">
                {foreach $allplugins as $plugin}
                    <option value="{{$plugin@key}|escape:"url"}{if $plugin.has_permission == false} selected="selected"{/if}">{$plugin.b->properties.name|escape:"html"}</option>
                {/foreach}
                </select>
            </div>

            <div class="form_select">
                <label for="forbidden_hooks">{$CONST.PERMISSION_FORBIDDEN_HOOKS}</label>
                <select name="serendipity[forbidden_hooks][]" multiple="multiple" size="5">
                {foreach $allhooks as $hook}
                    <option value="{{$hook@key}|escape:"url"}"{$hook.has_permission == false} 'selected="selected"'}>{{$hook@key}|escape:"html"}</option>
                {/foreach}
                </select>
            </div>
        {else}
            <span class="msg_notice">{$CONST.PERMISSION_FORBIDDEN_ENABLE_DESC}</span>
        {/if}
        {if $edit}
            <input type="submit" name="SAVE_EDIT" value="{$CONST.SAVE}"> {$CONST.WORD_OR} <input type="submit" name="SAVE_NEW" value="{$CONST.CREATE_NEW_GROUP}">
        {else}
            <input type="submit" name="SAVE_NEW" value="{$CONST.CREATE_NEW_GROUP}">
        {/if}
    </form>
{else}
    {if $delete}
    <form action="?serendipity[adminModule]=groups" method="post">
        {$formToken}
        <input type="hidden" name="serendipity[group]" value="{$group_id|escape:"html"}">
        <h2>{$CONST.DELETE_GROUP|sprintf:"{$group_id}":"{$group.name|escape:"html"}"}</h2>
        <div id="groups_delete_action">
            <input type="submit" name="DELETE_YES" value="{$CONST.DUMP_IT}">
            <input type="submit" name="NO" value="{$CONST.NOT_REALLY}">
        </div>
    </form>
    {/if}
{/if}
