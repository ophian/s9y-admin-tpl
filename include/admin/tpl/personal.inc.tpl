{* HTML5: Yes *}
{* jQuery: NN *}

{if $adminAction == 'save'}
    {if $not_authorized}
    <span class="msg_error">{$CONST.CREATE_NOT_AUTHORIZED_USERLEVEL}</span>
    {elseif $empty_username}
    <span class="msg_error">{$CONST.USERCONF_CHECK_USERNAME_ERROR}</span>
    {elseif $password_check_fail}
    <span class="msg_error">{$CONST.USERCONF_CHECK_PASSWORD_ERROR}</span>
    {else}
    <span class="msg_success">{$CONST.MODIFIED_USER|sprintf:"{$realname|escape:"html"}"} ?></span>
    {/if}
{/if}
<form action="?serendipity[adminModule]=personal&amp;serendipity[adminAction]=save" method="post">
    {$formToken}
    {$config}
    <input type="submit" name="SAVE" value="{$CONST.SAVE}">
</form>
